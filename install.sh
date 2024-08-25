#!/bin/bash

swiftc -o LidLink LidStateBluetoothManager.swift

sudo mv LidLink /usr/local/bin/

mkdir -p ~/Library/LaunchAgents

cp com.user.lidlink.plist ~/Library/LaunchAgents/

launchctl load ~/Library/LaunchAgents/com.user.lidlink.plist

echo "Installation complete. LidLink will start automatically on next login."