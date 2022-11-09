#!/bin/bash

curl="/usr/bin/curl --connect-timeout 1 --silent"
jq="/usr/bin/jq -r"
default_metadata=metadata.paperspace.com

get_metadata() {
  $curl $default_metadata/meta-data/machine
  return $?
}

/bin/systemctl status lightdm
X_running=$?

if [ "$X_running" -eq 0 ]; then
 service lightdm stop
fi

metadata=`get_metadata`
hostname=`printf '%s\n' "$metadata" | $jq '.hostname'`
hostnamectl set-hostname "$hostname"
sed -i "s/HOSTNAME/$(hostname)/g" /etc/hosts

if [ "$X_running" -eq 0 ]; then
 service lightdm start
fi

service notify-up restart
echo "service syslog restart" | at now + 1 minute
