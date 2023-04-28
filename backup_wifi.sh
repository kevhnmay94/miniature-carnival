#! /bin/bash
# WifiBridge must be active first
while true
do
 nmcli d wifi list --rescan yes | grep -e "E8:FC:AF:F5:D7:55"
 if [[ $? != 0 ]]; then
  echo "Wifi down, switching to backup"
  nmcli c show --active | grep Hotstop
  if [[ $? != 0 ]]; then
   nmcli c up Hotstop
  fi
 else
  echo "Wifi up, turn off backup"
  nmcli c show --active | grep Hotstop
  if [[ $? == 0 ]]; then
   nmcli c down Hotstop
  fi
 fi
 sleep 20
done
