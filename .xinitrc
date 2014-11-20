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

# Enable restart X ctrl + alt + back and change keymap with both shifts
setxkbmap -option terminate:ctrl_alt_bksp,grp:shifts_toggle es,us
#setxkbmap -option grp:switch,grp:shifts_toggle,grp_led:scroll es,us
xset led named "Scroll Lock"
xset r rate 250 60

# Turns off the system bell
/usr/bin/xset b off

xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/misc
xset +fp $HOME/.fonts
xset fp rehash

xrdb -merge ~/.Xresources &

xsetroot -cursor_name left_ptr &

#Swap mayus and ESC for ViM
xmodmap ~/dotfiles/.Xmodmap

#Pulseaudio on systray
pasystray &
#Auto lower brightness
#xset -q (To check options)
#xset +dpms
#xset dpms 0 0 300

mpd &

urxvtd -q -o -f

wicd-gtk -t &
#start-pulseaudio-x11
#pulseaudio --start

#xrandr -q | grep VGA1 && xrandr --output VGA1 --mode 1920x1080 --output LVDS1 --off

# Auto mounts USB to /media/
udiskie --tray &

#Auto lock screen
xss-lock slock &

#SSH agent
eval $(ssh-agent)

# Normal cursor
DEFAULT_SESSION=dwm

#[ -z $1 ] && my_session=$DEFAULT_SESSION || my_session=$1

case $1 in
bspwm)
	PANEL_FIFO=/tmp/panel-fifo
	PANEL_HEIGHT=15
	PANEL_FONT_FAMILY="-*-terminus-medium-r-normal-*-12-*-*-*-c-*-*-1"
	export PANEL_FIFO PANEL_HEIGHT PANEL_FONT_FAMILY
	#~/panel/panel &
	fbxkb &
	sxhkd &
	sh ~/.fehbg
	wmname LG3D
	exec bspwm
	;;
dwm)
	conky -c ~/conky.conf | while read -r; do xsetroot -name "$REPLY"; done &
	wmname LG3D
	fbxkb &
	#xfce4-power-manager &
	#parcellite &

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
xmonad)
	exec xmonad
	;;
*)
	exec $DEFAULT_SESSION
	;;
esac
