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
setxkbmap -option terminate:ctrl_alt_bksp

setxkbmap es
xset led named "Scroll Lock"

xrdb -merge ~/.Xresources &

#mpd

urxvtd -q -o -f

xset +fp /usr/share/fonts/local
xset fp rehash

#Bajar brillo de la pantalla auto
#xset -q(sirve para mirar opciones
#xset +dpms
#xset dpms 0 0 300

#wicd-gtk -t &
#start-pulseaudio-x11
pulseaudio --start

xrandr -q | grep VGA1 && xrandr --output VGA1 --mode 1920x1080 --output LVDS1 --off

DEFAULT_SESSION=dwm

if [ -z $1 ]; then
	mi_sesion=dwm
else
	mi_sesion=$1
fi

case $mi_sesion in
dwm)
	wmname LG3D
	#xfce4-power-manager &
	parcellite &

	sh ~/.fehbg

	#while true; do
	#	CURVOL=`amixer get Master | awk '/Mono.+/ {print $6=="[off]"?$6:$4}' | tr -d '[]'`
	#	xsetroot -name "Vol: $CURVOL Bateria: $(acpi | awk -F' '  '{print $4,$5}') Espacio libre: $(df -h|grep root|awk '{print $4}') $(date +"%d/%m - %H:%M:%S")"
	#	sleep 1
	#done &

	conky -c ~/conky.conf | while read -r; do xsetroot -name "$REPLY"; done &

	exec dwm
	;;

xfce4)
	exec startxfce4
	;;
openbox)
	compton &
	tint2 &
	volumeicon &
	avant-window-navigator &
	sh ~/.fehbg
	exec openbox
	;;
lxde)
	exec openbox
	exec startlxde
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac

