#!/bin/bash

MAKO_LOCAL="/home/$USER/.local/state/"
FIFO="mako_notifications.fifo"

update_line () {
	LAST=`makoctl history | head -n 1 | cut -d ' ' -f 3- -`
	NUM=`makoctl history | grep Notification | wc --lines`
	echo '{"text": "'"$LAST"'", "tooltip":"'$NUM' old notifications"}'
}

sleep_update () {
	sleep 10.2
	update_line
}

if [ "$1" == "-wb" ] ; then
	cd "$MAKO_LOCAL"
	rm -f "$FIFO"
	mkfifo "$FIFO"
	update_line
	while true ; do
		while read line ; do
			update_line
			sleep_update &
		done < "$FIFO"
	done
elif [ "$1" == "-pop" ] ; then
	makoctl mode -a pop 
	sleep 0.05
	makoctl restore 
	sleep 0.05
	makoctl dismiss -h 
	sleep 0.05
	makoctl mode -r pop 
	sleep 0.05
	echo "pop" > "${MAKO_LOCAL}/${FIFO}"
elif [ "$1" == "-show" ] ; then
	makoctl mode -a show
	sleep 0.05
	makoctl restore 
	sleep 0.05
	makoctl mode -r show
	sleep 0.05
	echo "show" > "${MAKO_LOCAL}/${FIFO}"
else
	echo "$1" > ${MAKO_LOCAL}/${FIFO}
fi
