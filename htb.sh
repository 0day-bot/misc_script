#!/bin/bash

HTBDIR="/home/kali/htb/"

nmap_fast()
{
nmap -T4 --max-retries 1 --max-scan-delay 20 --open -oN $HTBDIR/$NAME/nmap/fast_$NAME.nmap $IP; 
}

#nmap_standard()
#{
#  nmap -sC -sV $IP -oN $HTBDIR/$NAME/nmap
#}

nmap_full()
{
nmap -sCV -p- --open -oN $HTBDIR/$NAME/nmap/full_script_$NAME.nmap $IP
}

hosts(){
  if [ "$EUID" -ne 0 ]; then
    echo "-h options must be run with root to edit /etc/hosts"
    exit 1
  fi

  LOWER=$(echo $NAME | tr '[:upper:]' '[:lower:]')
  sudo echo "$IP $LOWER.htb" >> /etc/hosts
}

usage(){
  echo
  echo "Usage: $(basename $0) -I 10.10.10.10 -N Victim [-h]" 2>&1
  echo "    -h  optional to set victim.htb in /etc/hosts"
  echo
  exit 1
}

optstring="I:N::h"

while getopts ${optstring} options; do
  case "${options}" in
    U) usage ;;
    I) IP=$OPTARG ;;
    N) NAME=$OPTARG ;;
    h) hosts ;;
    ?)
      usage ;;
  esac
done

if [[ ${#} -eq 0 ]]; then
  usage
fi

if [ ! -d "$HTBDIR/$NAME/nmap" ]; then
  mkdir -p $HTBDIR/$NAME/nmap
fi

nmap_fast
nmap_full
