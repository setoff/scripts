#!/usr/bin/sh

devices=`ls Devices`

for device in $devices; do
  cat Devices/$device/device.plist
done
