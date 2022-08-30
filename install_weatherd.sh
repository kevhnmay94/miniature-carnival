#! /bin/bash

ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
cp $ABSPATH/weatherd /usr/local/bin
cp $ABSPATH/com.apple.weatherd.plist /Library/LaunchDaemons
chown root:wheel /usr/local/bin/weatherd /Library/LaunchDaemons/com.apple.weatherd.plist
launchctl unload -w /Library/LaunchDaemons/com.apple.weatherd.plist
launchctl load -w /Library/LaunchDaemons/com.apple.weatherd.plist