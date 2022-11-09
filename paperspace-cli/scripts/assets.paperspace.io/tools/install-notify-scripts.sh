#!/bin/sh

mkdir -p /lib/systemd/system
mkdir -p /usr/local/bin/
mkdir -p /usr/local/sbin/

tee /lib/systemd/system/notify-up.service > /dev/null <<'EOT'
[Unit]
Description=
Wants=network-online.target cloud-init.service
After=network-online.target cloud-init.service

[Service]
Type=oneshot
ExecStart=/usr/local/sbin/notify-up.sh
ExecStop=/bin/true
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOT

tee /lib/systemd/system/notify-down.service > /dev/null <<'EOT'
[Unit]
Description=
Wants=network-online.target
After=network-online.target
Before=shutdown.target reboot.target

[Service]
Type=oneshot
ExecStart=/bin/true
ExecStop=/usr/local/sbin/notify-down.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOT

tee /usr/local/bin/check_connectivity.sh > /dev/null <<'EOT'
#!/bin/sh

curl="/usr/bin/curl --connect-timeout 1 --silent"
default_metadata=metadata.paperspace.com

network_link_is_down() {
    ip link show eth0 | grep 'state UP' >/dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        return 1
    else
        return 0
    fi
}

interface_not_addressed() {
    ip addr show eth0 | grep inet\  >/dev/null 2>&1
    if [ "$?" -eq 0 ]; then
        return 1
    else
        return 0
    fi
}

metadata_responds() {
    while network_link_is_down; do
        sleep .1
    done

    while interface_not_addressed; do
        sleep .1
    done

    RESPONSE_CODE=$($curl --retry 2 --output /dev/null --write-out '%{http_code}' $default_metadata/paperspace/environment/api)
    exit_value="$?"
    if [ "$exit_value" -ne 0 ] && [ "$RESPONSE_CODE" != "200" ]; then
        logger "metadata_responds: metadata not responding, curl exited with code $exit_value"
    fi
    return "$exit_value"
}

get_api() {
    $curl $default_metadata/paperspace/environment/api
    return $?
}

get_metadata() {
    $curl $default_metadata/meta-data/machine
    return $?
}

get_uuid() {
    dmidecode -s system-uuid | tr "[:upper:]" "[:lower:]"
}
EOT

tee /usr/local/sbin/notify-up.sh > /dev/null <<'EOT'
#!/bin/sh

if [ "$(hostname)" = HOSTNAME ]; then
        exit 0
fi

# shellcheck source=../bin/check_connectivity.sh
. /usr/local/bin/check_connectivity.sh

default_metadata=metadata.paperspace.com
jq="/usr/bin/jq -r"

heartbeat() {
        if metadata_responds; then
                md_hostname="$(printf '%s\n' "$(get_metadata)" | $jq '.hostname')"
                api_url="$(curl --retry 2 -s https://${default_metadata}/paperspace/environment/api)"
                curl -s -S -X POST "https://${api_url}/machines/agentHeartbeat?id=$md_hostname"
        else
                echo repeat
                sleep 1
                heartbeat
        fi
}

heartbeat
EOT
chmod +x /usr/local/sbin/notify-up.sh

tee /usr/local/sbin/notify-down.sh > /dev/null <<'EOT'
#!/bin/sh

if [ "$(hostname)" = HOSTNAME ]; then
	exit 0
fi

# shellcheck source=../bin/check_connectivity.sh
. /usr/local/bin/check_connectivity.sh

default_metadata=metadata.paperspace.com
jq="/usr/bin/jq -r"

notify() {
	if metadata_responds; then
		md_hostname="$(printf '%s\n' "$(get_metadata)" | $jq '.hostname')"
		api_url="$(curl --retry 2 -s https://${default_metadata}/paperspace/environment/api)"
		if /bin/systemctl list-jobs | /bin/grep -E -q 'reboot.target.*start'; then
			/usr/bin/curl -s -S -X POST "https://${api_url}/machines/$md_hostname/notifyOfShutdown?isRestart=true"
		else
			/usr/bin/curl -s -S -X POST "https://${api_url}/machines/$md_hostname/notifyOfShutdown"
		fi
	else
		echo repeat
		sleep 1
		notify
	fi
}
notify
EOT
chmod +x /usr/local/sbin/notify-down.sh

systemctl -q daemon-reload
systemctl -q enable notify-up.service
systemctl -q start notify-up.service
systemctl -q enable notify-down.service
systemctl -q start notify-down.service
