#!/bin/bash

ID="$1"

echo "$ID"

APP_NAME=`makoctl list | grep "$ID" -A 3 | grep "App name" | cut -d ' ' -f 5- -`

echo "$APP_NAME"
SUB_NAME=`echo "$APP_NAME" | cut -d ':' -f 1 -`
echo $SUB_NAME
if [ "$SUB_NAME" = "IMAP MAIL" ] ; then
	MSG_ID=`echo "$APP_NAME" | cut -d ':' -f 2 -`
	python ~/.config/waybar/mail/imap_utils.py delete "$MSG_ID"
	makoctl dismiss -n "$ID" --no-history
	exit
fi

echo "$APP_NAME" > /tmp/tmp
swayjmp "$APP_NAME"

makoctl menu -n "$ID" ~/.config/mako/mako-default.sh 
makoctl dismiss -n "$ID" --no-history
