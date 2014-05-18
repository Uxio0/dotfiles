#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
# exec startxfce4
# ...or the Window Manager of your choice

# enable restart X
# Change keymap with both shifts
setxkbmap -option terminate:ctrl_alt_bksp,grp:shifts_toggle es,us
#setxkbmap -option grp:switch,grp:shifts_toggle,grp_led:scroll es,us
xset led named "Scroll Lock"

xrdb -merge ~/.Xresources &

#mpd

urxvtd -q -o -f

xset +fp /usr/share/fonts/local
xset fp rehash

#Auto lower brightness
#xset -q (To check options)
#xset +dpms
#xset dpms 0 0 300

#wicd-gtk -t &
#start-pulseaudio-x11
#pulseaudio --start

#xrandr -q | grep VGA1 && xrandr --output VGA1 --mode 1920x1080 --output LVDS1 --off

DEFAULT_SESSION=dwm

#[ -z $1 ] && my_session=$DEFAULT_SESSION || my_session=$1

case $1 in
dwm)
	conky -c ~/conky.conf | while read -r; do xsetroot -name "$REPLY"; done &
	wmname LG3D
	#xfce4-power-manager &
	parcellite &

	sh ~/.fehbg

	#while true; do
	#	CURVOL=`amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}' | tr -d '[]'`
	#	xsetroot -name "Vol: $CURVOL Bateria: $(acpi | awk -F' '  '{print $4,$5}') Espacio libre: $(df -h|grep root|awk '{print $4}') $(date +"%d/%m - %H:%M:%S")"
	#	sleep 1
	#done &


	exec dwm
	;;

xfce4)
	exec startxfce4
	;;
openbox)
	obsetlayout 0 2 2 0
	fbxkb &
	compton &
	volumeicon &
	avant-window-navigator &
	#./dzenconky.sh &
	#tint2 &
	#conky -c conkybar.conf &
	sh ~/.fehbg
	exec openbox-session
	;;
lxde)
	obsetlayout 0 2 2 0
	exec startlxde
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
