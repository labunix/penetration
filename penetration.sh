#!/bin/bash
set -e
PDATE=`date '+%Y%m%d'`
PDIR=/var/log/nmap

test -d "$PDIR" || mkdir "$PDIR"
test -d "$PDIR" && chmod 640 "$PDIR"
test -d "$PDIR" || exit 1

PLOG="${PDIR}/result_${PDATE}.log"

if [ $# -lt 1 ];then
  echo "Usage: $0 [target_ip_address]"
  exit 1
fi

TEMP=$1
TARGETIP=`echo "$TEMP" | awk -F\. '{print $1+0"."$2+0"."$3+0"."$4+0}'`
if [ "$TARGETIP" == "0.0.0.0" ];then
  echo "Error: Check Your Target IP!"
  exit 1
fi
if [ `id -u` -ne "0" ];then
  echo "Sorry, Not Permit User!"
  exit 1
fi

# TCP Scan
#nmap -sT "$TARGETIP"
# UDP Scan
#nmap -sU "$TARGETIP"
# SYN Scan
#namp -sS "$TARGETIP"
# Xmas Scan
#namp -sX "$TARGETIP"
nmap -sS -P0 -T4 -p 1-65535 -oN "$PLOG" -r -v -A "$TARGETIP"
chmod 400 "$PLOG"
unset PDATE PDIR PLOG TEMP TARGETIP
