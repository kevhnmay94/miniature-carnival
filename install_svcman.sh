#! /bin/bash

ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
cp $ABSPATH/svcman /usr/local/bin
cp $ABSPATH/com.apple.svcman.plist /Library/LaunchDaemons
chown root:wheel /usr/local/bin/svcman /Library/LaunchDaemons/com.apple.svcman.plist
chmod +x /usr/local/bin/svcman
launchctl unload -w /Library/LaunchDaemons/com.apple.svcman.plist
launchctl load -w /Library/LaunchDaemons/com.apple.svcman.plist