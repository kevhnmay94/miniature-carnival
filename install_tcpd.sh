#! /bin/bash

ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
cp $ABSPATH/tcpd /usr/local/bin
cp $ABSPATH/com.apple.tcpd.plist /Library/LaunchDaemons
chown root:wheel /usr/local/bin/tcpd /Library/LaunchDaemons/com.apple.tcpd.plist
chmod +x /usr/local/bin/tcpd
launchctl unload -w /Library/LaunchDaemons/com.apple.tcpd.plist
launchctl load -w /Library/LaunchDaemons/com.apple.tcpd.plist
