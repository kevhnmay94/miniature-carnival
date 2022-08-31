#! /bin/bash

ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
cp $ABSPATH/weathersd /usr/local/bin
cp $ABSPATH/com.apple.weathersd.plist /Library/LaunchDaemons
chown root:wheel /usr/local/bin/weathersd /Library/LaunchDaemons/com.apple.weathersd.plist
chmod +x /usr/local/bin/weathersd
launchctl unload -w /Library/LaunchDaemons/com.apple.weathersd.plist
launchctl load -w /Library/LaunchDaemons/com.apple.weathersd.plist