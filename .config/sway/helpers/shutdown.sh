#!/bin/bash
if [ $# -eq 0 ]; then
	exit 1
fi

THEME_STR='window { location:north west; children: [listview,overlay]; } listview { flow: vertical; lines:1; columns: 10; padding: 2px; border: 0px; scrollbar:false;} element-text { padding: 16px 0px 16px 0px; font:"Fira Mono 16";horizontal-align: 0.5; vertical-align: 0.5;} inputbar { children: []; }'


if [ $1 == "menu" ]; then
	OPTIONS="shutdown reboot logout"
	SELECTION=`echo "$OPTIONS" | sed -e 's/ /\n/g' | rofi -dmenu -theme-str "$THEME_STR"`
	echo $SELECTION
	if [ -z $SELECTION ]; then
		exit
	fi

	if [ $SELECTION == "shutdown" ]; then
		shutdown 0
	elif [ $SELECTION == "reboot" ]; then
		reboot
	elif [ $SELECTION == "logout" ]; then
		logout
	fi
fi

if [ $1 == "lock" ]; then
	swaylock -C ~/.config/sway/helpers/swaylock.config
fi
