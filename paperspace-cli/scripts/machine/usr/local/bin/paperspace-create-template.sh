#!/bin/sh

clear_logs='true'
clear_history='true'
clear_authorized_keys='true'
clear_root_homedir='true'
clear_paperspace_homedir='true'
clear_other='false'
other_files="
/var/lib/cloud/scripts/per-instance/ps_setpasswords.sh
/home/paperspace/vm-cleanup.sh
$REMOVE_FILES
"

usage(){
  cat <<EOF

Usage: $0 [-l] [-i] [-k] [-r] [-p] [-o] [-h|--help]
  -l  don't clear log files
  -i  don't clear history
  -k  don't clear authorized_keys files
  -r  don't clear root's homedir
  -p  don't clear paperspace's homedir
  -o  do clear other files (including REMOVE_FILES)

environment:
  REMOVE_FILES:   list of files or directories to remove
EOF
}

while [ -n "$1" ]; do
  case "$1" in
    -l)
      clear_logs='false'
      shift
      ;;
    -i)
      clear_history='false'
      shift
      ;;
    -k)
      clear_authorized_keys='false'
      shift
      ;;
    -r)
      clear_root_homedir='false'
      shift
      ;;
    -p)
      clear_paperspace_homedir='false'
      shift
      ;;
    -o)
      clear_other='true'
      shift
      ;;
    -h|--help)
      usage
      exit
      ;;
  esac
done

stop_service(){
  if [ -x `which systemctl` ]; then
    systemctl stop $1 > /dev/null 2>&1
  else
    stop $1 > /dev/null 2>&1
  fi
}

stop_lightdm_if_running(){
  ps ax | grep [l]ightdm > /dev/null
  if [ "$?" -eq 0 ]; then
    stop_service lightdm
  fi
}

make_hosts(){
  cat <<EOF > /etc/hosts
127.0.0.1	localhost
127.0.1.1	HOSTNAME

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback HOSTNAME
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
10.255.255.254 metadata.paperspace.com metadata
EOF
  chmod 644 /etc/hosts
}

make_hostname(){
  cat <<EOF > /etc/hostname
HOSTNAME
EOF
  chmod 644 /etc/hostname
}

remove_old_logfiles(){
  find /var/log -name '*.gz' -o -name '*.1' -o -name '*.0' -o -name '*.old' -exec rm -f {} \;
  find /var/log -type f -exec truncate -s0 {} \;
  truncate -s0 /home/paperspace/.xsession-errors
}

truncate_history_files(){
  truncate_files="
/etc/sudoers.d/90-cloud-init-users
/root/.bash_history
/root/.lesshst
/home/paperspace/.bash_history
/home/paperspace/.lesshst
"

  for f in $truncate_files; do
	  if [ -e "$f" ]; then
		  truncate -s0 $f
	  fi
  done
}

truncate_authorized_keys(){
  truncate -s0 /root/authorized_keys
  for d in /home/*; do
    if [ -e $d/.ssh/authorized_keys ]; then
      truncate -s0 $d/.ssh/authorized_keys
    fi
  done
}

clean_root_homedir(){
  rm -rf /root/*
}

clean_paperspace_homedir(){
  rm -rf /home/paperspace/.mozilla
  rm -f /home/paperspace/.ssh/known_hosts
  rm -f /home/paperspace/*
  rm -f /home/paperspace/.local/share/keyrings/*
}

clean_temp_dirs(){
  rm -f /var/crash/*
  rm -rf /tmp/*
  rm -rf /var/tmp/*
}

clean_ssh_host_keys(){
  rm -f /etc/ssh/*host*
}

clean_other(){
  rm -f $other_files
}

rearm_cloud_init(){
  rm -rf /var/lib/cloud/instance*
}

stop_lightdm_if_running
stop_service rsyslog
make_hosts
make_hostname
apt-get -qy clean
$clear_logs && remove_old_logfiles
$clear_history && truncate_history_files
$clear_authorized_keys && truncate_authorized_keys
$clear_root_homedir && clean_root_homedir
$clear_paperspace_homedir && clean_paperspace_homedir
$clear_other && clean_other
clean_temp_dirs
clean_ssh_host_keys
rearm_cloud_init
