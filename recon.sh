#!/bin/bash
# bug bounty recon script based on Vickie Li's bug bounty bootcamp master report
# Ian Mulhern
# 12/30/21 

WORDLIST="/usr/share/wordlists/SecLists/Discovery/Web-Content/raft-small-directories-lowercase.txt"

nmap_scan()
{
  nmap $DOMAIN > $DIRECTORY/nmap
  echo "The results of the nmap scan are stored in $DIRECTORY/nmap."
}
ffuf_scan()
{
  ffuf -w $WORDLIST -u http://$DOMAIN/FUZZ  -r -o $DIRECTORY/ffuf.json -e .php
  echo "The results of ffuf scan are stored in $DIRECTORY/ffuf.json."
}
crt_scan()
{
  curl "https://crt.sh/?q=$DOMAIN&output=json" -o $DIRECTORY/crt
  echo "The results of cert parsing is stored in $DIRECTORY/crt"
}

getopts "m:" OPTION
MODE=$OPTARG

for i in "${@:$OPTIND:$#}"
do

  DOMAIN=$1
  DIRECTORY=~/bb/${DOMAIN}_recon
  mkdir -p $DIRECTORY
  echo "Creating directory $DIRECTORY."

  case $MODE in 
    nmap-only)
      nmap_scan
      ;;
    ffuf-only)
      ffuf_scan
      ;;
    crt-only)
      crt_scan
      ;;
    *)
      nmap_scan
      ffuf_scan
      crt_scan
      ;;
  esac
  echo "Generationg Recon Report from output files....."
  TODAY=$(date)
  echo "This scan was created on $TODAY" > $DIRECTORY/report
    if [ -f $DIRECTORY/nmap ];then
      echo "Results for nmap:" >> $DIRECTORY/report
      grep -E "^\s*\S+\s+\S+\s+\S+\s*$" $DIRECTORY/nmap 2>/dev/null >> $DIRECTORY/report
    fi
    if [ -f $DIRECTORY/ffuf.json ];then
      echo "Results for ffuf:" >> $DIRECTORY/report
      jq ".results[].url" $DIRECTORY/ffuf.json 2>/dev/null | tr -d '"' 2>/dev/null >> $DIRECTORY/report
    fi
    if [ -f $DIRECTORY/crt ];then
      echo "Results for crt.sh:" >> $DIRECTORY/report
      jq -r ".[] | .name_value" $DIRECTORY/crt 2>/dev/null >> $DIRECTORY/report
    fi
done


