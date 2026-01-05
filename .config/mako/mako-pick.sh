#!/bin/bash

ID="$1"

APP_NAME=`makoctl list | grep "$ID" -A 1 | grep "App name" | cut -d ' ' -f 5- -`

echo "$APP_NAME" > /tmp/tmp
swayjmp "$APP_NAME"

makoctl menu -n "$ID" ~/.config/mako/mako-default.sh 
makoctl dismiss -n "$ID" --no-history
