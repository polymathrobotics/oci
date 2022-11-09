#!/bin/sh

jq="/usr/bin/jq -r"
curl="/usr/bin/curl --connect-timeout 1 --silent"
default_api=api.paperspace.io
default_metadata=metadata.paperspace.com

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
  RESPONSE_CODE=`$curl --retry 2 --output /dev/stderr --write-out '%{http_code}' $default_metadata/paperspace/environment/api`
  exit_value="$?"
  if [ "$exit_value" -ne 0 -a "$RESPONSE_CODE" != "200" ]; then
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
  dmidecode -s system-uuid | tr [:upper:] [:lower:]
}

is_desktop() {
  agent_type=`printf '%s\n' "$metadata" | $jq '.type'`
  if [ "$agent_type" = "LinuxDesktop" ]; then
    return 0
  else
    return 1
  fi
}

getrandpw() {
  < /dev/urandom tr -dc A-HJKMNP-Za-hjkmnp-z2-9 | head -c${1:-12};echo;
}

settemppw() {
  echo paperspace:${1} | chpasswd
}

setvncpw() {
  x11vnc -storepasswd ${1} /root/.vnc/passwd >> /dev/null 2>&1
}

sendpws() {
  if [ -n "$3" ]; then
    vnc_pw_args="-F vncpw=${3}"
  fi
  RESPONSE_CODE=`$curl --output /dev/stderr --write-out '%{http_code}' -X POST -F "temppw=${1}" $vnc_pw_args -F "vmId=${2}" https://${api_host}/machines/completeLinuxSetup`
  case "$RESPONSE_CODE" in
    204)
      logger password info updated
      no_such_machine=false
      retry_passwords=false
      return 0
      ;;
    404)
      logger "no machine with this id was found (error 404 from $api_host)"
      no_such_machine=true
      retry_passwords=false
      return 1
      ;;
    *)
      logger unknown error updating password for this machine
      no_such_machine=false
      retry_passwords=true
      return 2
      ;;
  esac
}

sendpws_wrapper() {
  if is_desktop; then
    sendpws $temppw $uuid $vncpw
  else
    sendpws $temppw $uuid
  fi
}

set_masters() {
  if metadata_responds; then
    api_host=`get_api`
    metadata_responded=true
  else
    api_host="$default_api"
    metadata_responded=false
  fi
}

set_passwords() {
  settemppw $temppw
  if is_desktop; then
    setvncpw $vncpw
  fi
}

set_ssh_keys() {
  printf '%s\n' "$metadata" | $jq '.publicSSHKeys[]' > /home/paperspace/.ssh/authorized_keys
}

retry_set_passwords_indefinitely() {
  while [ "$retry_passwords" = "true" ]; do
    logger initial_setup: problem sending temp password up to api, retrying...
    sendpws_wrapper
    sleep 5
  done
}

uuid=`get_uuid`
temppw=`getrandpw`
vncpw=`getrandpw`

while network_link_is_down; do
  sleep .1
done
net_link_up=true

while interface_not_addressed; do
  sleep .1
done
interface_addressed=true

set_masters

metadata=`get_metadata`
set_passwords
set_ssh_keys

sendpws_wrapper
if $no_such_machine && $metadata_responded; then
    api_host="$default_api"
    sendpws_wrapper
    if [ "$retry_passwords" = 'false' ]; then
        exit 0
      fi
    else
      retry_set_passwords_indefinitely
fi
