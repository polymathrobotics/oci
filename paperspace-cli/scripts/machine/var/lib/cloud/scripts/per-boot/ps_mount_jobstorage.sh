#!/bin/bash

curl="/usr/bin/curl --connect-timeout 1 --silent --show-error"
default_master=saltstackmaster.paperspace.io
default_api=api.paperspace.io
default_metadata=https://metadata.paperspace.com
default_gateway=$(/sbin/ip route show | grep default | cut -d" " -f3)
pub_datasets_server=169.254.169.253

get_metadata() {
  $curl $default_metadata/meta-data/machine
  return $?
}

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
  RESPONSE_CODE=`${curl} --retry 2 --output /dev/null --write-out '%{http_code}' ${default_metadata}/paperspace/environment/api`
  exit_value="$?"
  if [ "$exit_value" -ne 0 -a "$RESPONSE_CODE" != "200" ]; then
    logger "metadata_responds: metadata not responding, curl exited with code $exit_value"
  fi
  return "$exit_value"
}

prep_run() {
  if metadata_responds; then
          metadata=$(get_metadata)
          check_for_jobstorage
  else
          echo repeat
          sleep 1
          prep_run
  fi
}

check_for_jobstorage() {
  printf '%s\n' "$metadata"| jq .storageExports | grep null 2>&1 > /dev/null
  if [ "$?" -eq 0 ]; then
        exit 0
     else
        mount_jobstorage
  fi
}

mount_jobstorage() {
## Mount all user private datasets
  EXPORTS=($(printf '%s\n' "$metadata" | jq .storageExports | tr -d \"[],))
  for mountsource in $(echo ${EXPORTS[@]}); do
        mkdir -p /storage/$(echo ${mountsource} | cut -d/ -f3)
        mountpoint /storage/$(echo ${mountsource} | cut -d/ -f3) 2>&1 > /dev/null
             if [ "$?" -eq 1 ]; then
                echo Mounting job storage $(echo ${mountsource} | cut -d. -f4 | tr -d \", | tr /  " " | awk '{print "169.254.169."$1":/"$2"/"$3}')...
                ip route add $(echo ${mountsource} | cut -d. -f4 | tr -d \", | tr /  " " | awk '{print "169.254.169."$1"/32"}') via ${default_gateway}
                /sbin/mount.nfs $(echo ${mountsource} | cut -d. -f4 | tr -d \", | tr /  " " | awk '{print "169.254.169."$1":/"$2"/"$3}') /storage/$(echo ${mountsource} | cut -d/ -f3) -s -w
                if [ "$?" -ne 0 ]; then
	           echo "Couldn't mount job storage /storage/$(echo ${mountsource} | cut -d/ -f3)!"
                   rm -rf /storage/$(echo ${mountsource} | cut -d/ -f3)
                else
		   echo Job storage /storage/$(echo ${mountsource} | cut -d/ -f3) mounted
                   chown paperspace:paperspace /storage/$(echo ${mountsource} | cut -d/ -f3)
                fi
             else
                continue
             fi
  done
## Mount public datasets
  mkdir -p /storage/public_datasets
  echo Mounting public datasets...
  ip route add ${pub_datasets_server} via ${default_gateway}
  /sbin/mount.nfs ${pub_datasets_server}:/export/datasets /storage/public_datasets -r -s
        if [ "$?" -ne 0 ]; then
		echo "Couldn't mount public datasets!"
                rm -rf /storage/public_datasets
	else
		echo Public datasets mounted on /storage/public_datesets
        fi
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
