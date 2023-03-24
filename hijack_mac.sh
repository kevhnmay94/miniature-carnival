#! /bin/bash
INTERFACE="en1"
MYMAC="B4:2E:99:82:22:E8"
IPSET="192.168.0.238"
while true
do
ping 8.8.8.8 -c 1
if [[ $? -eq 0 || "$LASTMAC" != "$MYMAC" ]]; then
  OLDMAC="72:23:B8:BC:33:4D"
  IPLAST=`ifconfig $INTERFACE | awk -F"[ ',/]+" '/inet /{print $2}'`
  ifconfig $INTERFACE delete $IPLAST
  ifconfig $INTERFACE add $IPSET
  ifconfig $INTERFACE down
  ifconfig $INTERFACE ether $OLDMAC
  ifconfig $INTERFACE up
  IPNOW=`nmap -sn 192.168.0.0/24 | grep -B 2 ${MYMAC^^} | grep scan | awk '{print $5}'`
  echo ${MYMAC^^}
  echo $IPNOW
  echo $IPLAST
  if [ -n "$IPNOW" ]; then
    if [ "$IPSET" != "$IPNOW" ]; then
      ifconfig $INTERFACE delete $IPSET
      ifconfig $INTERFACE add $IPNOW
      ifconfig $INTERFACE down
      ifconfig $INTERFACE ether $MYMAC
      ifconfig $INTERFACE up
    fi
  fi 
fi
ifconfig $INTERFACE down
sleep 5
ifconfig $INTERFACE up
sleep 30
done
