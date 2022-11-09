#!/bin/sh

curl="/usr/bin/curl --connect-timeout 1 --silent --show-error"

network_link_is_down() {
  ip link show eth0 | grep 'state UP' 2>&1 > /dev/null
  if [ "$?" -eq 0 ]; then
    return 1
  else
    return 0
  fi
}

interface_not_addressed() {
  ip addr show eth0 | grep inet\  2>&1 > /dev/null
  if [ "$?" -eq 0 ]; then
    return 1
  else
    return 0
  fi
}

metadata_responds() {
  RESPONSE_CODE=`${curl} --retry 2 --output /dev/null --write-out '%{http_code}' https://metadata.paperspace.com/paperspace/environment/api`
  exit_value="$?"
  if [ "$exit_value" -ne 0 -a "$RESPONSE_CODE" != "200" ]; then
    logger "metadata_responds: metadata not responding, curl exited with code $exit_value"
  fi
  return "$exit_value"
}

prep_run() {
  if metadata_responds; then
    fetch_script
  else
    echo repeat
    sleep 1
    prep_run
  fi
}

fetch_script() {
  curl -sS --retry 20 --retry-connrefused https://metadata.paperspace.com/script | bash > /var/log/startup-script-output.log 2>&1
}

while network_link_is_down; do
  sleep .1
done
net_link_up=true

while interface_not_addressed; do
  sleep .1
done
interface_addressed=true

prep_run
