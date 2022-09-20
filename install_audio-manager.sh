#! /bin/bash

ABSPATH=$(cd "$(dirname "$0")"; pwd -P)
cp $ABSPATH/audio-manager /usr/local/bin
cp $ABSPATH/audio-manager.service /usr/lib/systemd/system
chown root:root /usr/local/bin/audio-manager /usr/lib/systemd/system/audio-manager.service
chmod +x /usr/local/bin/audio-manager
systemctl daemon-reload
systemctl enable --now audio-manager.service