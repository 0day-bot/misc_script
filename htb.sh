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

#nmap_full()
#{

#}

usage(){
  echo
  echo "Usage: ./htb.sh -I 10.10.10.10 -N Victim"
  echo "    -h  optional to set victim.htb in /etc/hosts"
  echo
  exit 1
}

while getopts I:N:h: options; do
  case "${options}" in
    U) usage ;;
    I) IP=$OPTARG ;;
    N) NAME=$OPTARG ;;
    h) hosts="True" ;;
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
