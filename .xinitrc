#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

#if [ -d /etc/X11/xinit/xinitrc.d ]; then
#  for f in /etc/X11/xinit/xinitrc.d/*; do
#    [ -x "$f" ] && . "$f"
#  done
#  unset f
#fi

# Enable restart X ctrl + alt + back and change keymap with both shifts
setxkbmap -option terminate:ctrl_alt_bksp,grp:shifts_toggle es,us
#setxkbmap -option grp:switch,grp:shifts_toggle,grp_led:scroll es,us
numlockx on
#xset led named "Scroll Lock"
xset r rate 250 60

# redshift -l 49.26:-123.23 &

# Turns off the system bell
/usr/bin/xset b off

# Fonts
xset +fp /usr/share/fonts/local
xset +fp /usr/share/fonts/misc
xset +fp $HOME/.fonts
xset fp rehash

xrdb -merge ~/.Xresources &
xsetroot -cursor_name left_ptr &

#Swap mayus and ESC for ViM
if [ -s ~/dotfiles/.Xmodmap ]; then
    xmodmap ~/dotfiles/.Xmodmap
fi

#Auto lower brightness
#xset -q (To check options)
#xset +dpms
#xset dpms 0 0 300

# Network manager applet
nm-applet   2>&1 > /dev/null &

# Pulseaudio applet
pasystray &

# Auto mounts USB to /media/
udiskie --tray &

#Auto lock screen
xss-lock slock &

#SSH agent
eval $(ssh-agent)

#Redshift for auto regulate screen colors temperature
#redshift -l 43.34:8.45&

DISPLAYS=($(xrandr -q | grep ' connected' | sed -e 's/\(.*\)connected.*/\1/g'))
if [[ ${#DISPLAYS[@]} == 2 ]]; then
    xrandr --output ${DISPLAYS[2]} --primary --preferred --auto --left-of ${DISPLAYS[1]}
fi

case $1 in
    bspwm)
        # Reparenting Java
        export _JAVA_AWT_WM_NONREPARENTING=1

        # https://github.com/lxqt/lxqt-qtplugin#configuration-usage
        export QT_QPA_PLATFORMTHEME=lxqt
        wmname LG3D
        # Install xorg-xprop
        source ~/dotfiles/bin/java_nonreparenting_wm_hack.sh

        sxhkd &
        clipit &
        # compton --backend glx --paint-on-overlay --vsync opengl-mswc &

        if [ -f /usr/bin/lxqt-notificationd ]; then
            /usr/bin/lxqt-notificationd &
        else
            dunst &
        fi

        # Install feh
        sh ~/.fehbg
        [ -f ~/.runonce ] && sh ~/.runonce
        exec bspwm
        ;;
    xfce4)
        exec startxfce4
        ;;
    lxqt)
        sxhkd &
        fbxkb &
        exec startlxqt
        ;;
    lxde)
        obsetlayout 0 2 2 0
        exec startlxde
        ;;
    *)
        exec startlxqt
        ;;
esac
# vim: ft=sh ts=4 sw=4 tw=0 fdm=marker foldlevel=0 :
