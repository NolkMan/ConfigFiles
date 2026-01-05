#!/bin/bash
if [ $# -eq 0 ]; then
	exit 1
fi

BASE=/tmp/screenshot.tmp
LOC=$BASE/location
NAME=$BASE/name

get_location() {
	TLOC=$(cat $LOC)
	TNAME=$(cat $NAME)
	OO=${TLOC}/${TNAME}_$(date +%s).png
	if [[ $TLOC == "/dev/null" ]]; then 
		OO=/dev/null
	fi
	echo $OO
}

if [ $1 == "window" ]; then
	grim -g "$(swaymsg -t get_tree | jq -j '.. | select(.type?) | select(.focused).rect | "\(.x),\(.y) \(.width)x\(.height)"')" - | tee $(get_location) | wl-copy -t image/png
fi

if [ $1 == "selection" ]; then 
	grim -g "$(slurp)" - | tee $(get_location) | wl-copy -t image/png
fi

if [ $1 == "extract_text" ]; then
	grim -g "$(slurp)" - | tesseract - - 2>/dev/null | wl-copy
fi
	

if [ $1 == "setname" ]; then
	TNAME=$(cat $NAME | rofi -dmenu)
	if [[ $TNAME == "" ]]; then
		TNAME=screencapture
	fi
	echo $TNAME > $NAME
fi

if [ $1 == "setdir" ]; then
	TLOC=$(find ~ -path '*/.*' -prune -o -type d -printf '%P\n' | rofi -dmenu)
	if [[ $TLOC == "" ]]; then
		TLOC=/dev/null
	fi
	if [[ ! ${TLOC:0:1} == "/" ]]; then
		TLOC=~/$TLOC
	fi
	echo $TLOC > $LOC
	echo "screencapture" > $NAME
	mkdir $TLOC
fi

if [ $1 == "init" ]; then
	mkdir $BASE
	echo "/dev/null" > $LOC
	echo "screencapture" > $NAME
fi


