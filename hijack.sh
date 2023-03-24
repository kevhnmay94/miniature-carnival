#! /bin/bash
LASTMAC=`cat /etc/network/lastmac`
INTERFACE="eth0"
MYMAC=`ip a s $INTERFACE | grep ether | awk '{print $2}'`
while true
do
ping 8.8.8.8 -c 1
if [[ $? -eq 0 || "$LASTMAC" != "$MYMAC" ]]; then
  echo $MYMAC > /etc/network/lastmac
  OLDMAC="72:23:B8:BB:00:FF"
  IPLAST=`ip a s $INTERFACE | awk -F"[ ',/]+" '/inet /{print $3}'`
  ip addr del $IPLAST/24 dev $INTERFACE
  ip addr add 192.168.0.212/24 dev $INTERFACE
  ip link set dev $INTERFACE down
  ip link set dev $INTERFACE address $OLDMAC
  ip link set dev $INTERFACE up
  IPNOW=`nmap -sn 192.168.0.0/24 | grep -B 2 ${MYMAC^^} | grep scan | awk '{print $5}'`
  echo ${MYMAC^^}
  echo $IPNOW
  echo $IPLAST
  if [ -n "$IPNOW" ]; then
    if [ "192.168.0.212" != "$IPNOW" ]; then
      cp /etc/network/interfaces.bak /etc/network/interfaces
      sed -i -e "s/192.168.0.79/$IPNOW/g" /etc/network/interfaces
      ip addr del 192.168.0.212/24 dev $INTERFACE
      ip addr add $IPNOW/24 dev $INTERFACE
      ip link set dev $INTERFACE down
      ip link set dev $INTERFACE address $MYMAC
      ip link set dev $INTERFACE up
    fi
  fi 
fi
ip link set dev $INTERFACE down
sleep 5
ip link set dev $INTERFACE up
sleep 30
done
