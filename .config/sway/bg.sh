#!/usr/bin/bash

if [[ -z $1 ]]; then
	cd ~/Pictures/screen
	[[ ! -f /tmp/my/nextbg ]] && cp ~/.local/state/nextbg /tmp/my/nextbg
	bg=$(head -n 1 /tmp/my/nextbg 2> /dev/null)
	if [[ $bg ]]; then
		sed -i '1d' /tmp/my/nextbg
	else
		bg=(*)
		printf '%s\n' "${bg[@]:1}" | shuf > /tmp/my/nextbg
	fi
fi

killall swaybg 2> /dev/null
swaybg -i "${bg:=$1}" -m fill &

[[ $bg == /* ]] || bg="$PWD/$bg"
echo "$bg" > /tmp/my/bg
