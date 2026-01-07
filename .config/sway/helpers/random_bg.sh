#!/bin/bash

P=~/.config/sway/backgrounds/
F=`ls "$P" | shuf -n 1`
echo $P$F
