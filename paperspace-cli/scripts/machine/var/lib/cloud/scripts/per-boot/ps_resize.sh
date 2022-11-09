#!/bin/bash

ROOT_VG=$(lvs --noheadings | grep root | awk '{print $2}')
ROOT_DEV=$(printf "fix\n" | parted ---pretend-input-tty /dev/xvda print | grep lvm | awk '{print $1}')

if [ ${ROOT_DEV} == 5 ]; then
	parted /dev/xvda resizepart 2 100%
fi

parted /dev/xvda resizepart ${ROOT_DEV} 100%

pvresize /dev/xvda${ROOT_DEV}
lvextend /dev/${ROOT_VG}/root -r -l 100%VG

exit 0
