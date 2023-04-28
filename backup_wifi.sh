#! /bin/bash
while true
do
 nmcli d wifi list --rescan yes | grep -e "E8:FC:AF:F5:D7:55"
 if [[ $? != 0 ]]; then
  echo "Wifi down, switching to backup"
  nmcli c show --active | grep WifiBridge
  if [[ $? != 0 ]]; then
   nmcli c down "Wired connection 1"
   nmcli c up WifiBridge
  fi
 else
  echo "Wifi up, turn off backup"
  nmcli c show --active | grep "Wired connection 1"
  if [[ $? != 0 ]]; then
   nmcli c down WifiBridge
   nmcli c up "Wired connection 1"
  fi
 fi
 sleep 30
done
