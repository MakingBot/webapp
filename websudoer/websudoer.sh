#!/bin/bash

currentDir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function setHostname()
{
   oldhostname=$(hostname)
   echo $1 > /etc/hostname
   echo $(cat /etc/hosts | sed '/$oldhostname/d') > /etc/hosts
   echo "127.0.1.1 $1" >> /etc/hosts
   /usr/sbin/service avahi-daemon restart
}

cmd=$1
echo $@ >> $currentDir/log.info

case $cmd in
   "wpa_cli")
      "/sbin/$@"
      ;;
   "nmcli")
      "/usr/bin/$@"
      ;;
   "getHostname")
      "/bin/hostname"
      ;;
   "setHostname")
      setHostname $2
      ;;
   *)
      echo cmd $cmd is wrong
      ;;
esac
