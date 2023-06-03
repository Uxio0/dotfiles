#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

# Swap mayus and ESC for ViM
if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


function xinit_run_programs {
    # Network manager applet
    nm-applet   2>&1 > /dev/null &

    # Bluetooth applet
    blueman-applet 2>&1 > /dev/null &

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
    # redshift -l 49.26:-123.23 &

}

# Enable switch CAPS LOCK - ESCAPE, restart X ctrl + alt + back, change keymap with both shifts
setxkbmap -option caps:escape,terminate:ctrl_alt_bksp,grp:shifts_toggle es,us
xset r rate 250 60

# Turns off the system bell
/usr/bin/xset b off
xsetroot -cursor_name left_ptr &

if [[ "$(hostname)" == 'vbox-new-arch' ]]; then
    # Running in a virtual machine
    VBoxClient-all
    export LIBGL_ALWAYS_SOFTWARE=1
fi

#Auto lower brightness
#xset -q (To check options)
#xset +dpms
#xset dpms 0 0 300

DISPLAYS=($(xrandr -q | grep ' connected' | sed -e 's/\(.*\)connected.*/\1/g'))
if [[ ${#DISPLAYS[@]} == 2 ]]; then
    xrandr --output ${DISPLAYS[@]:1:1} --primary --preferred --auto --left-of ${DISPLAYS[@]:0:1}
fi

case $1 in
    bspwm)
        xinit_run_programs
        # Reparenting Java
        export _JAVA_AWT_WM_NONREPARENTING=1
        export AWT_TOOLKIT=MToolkit

        # https://github.com/lxqt/lxqt-qtplugin#configuration-usage
        # export QT_QPA_PLATFORMTHEME=lxqt
        wmname LG3D
        # Install xorg-xprop
        source ~/dotfiles/bin/java_nonreparenting_wm_hack.sh

        sxhkd &
        clipit &
        # compton --backend glx --paint-on-overlay --vsync opengl-mswc &
        picom &


		if [ -f /usr/lib/xfce4/notifyd/xfce4-notifyd ]; then
			/usr/lib/xfce4/notifyd/xfce4-notifyd &
        else
            dunst &
        fi

        # Install feh
        sh ~/.fehbg
        [ -f ~/.runonce ] && sh ~/.runonce
        exec bspwm
        ;;
    xfce4)
        xinit_run_programs
        sxhkd &
        exec startxfce4
        ;;
    lxqt)
        xinit_run_programs
        sxhkd &
        fbxkb &
        exec startlxqt
        ;;
    lxde)
        xinit_run_programs
        obsetlayout 0 2 2 0
        exec startlxde
        ;;
    plasma)
        export DESKTOP_SESSION=plasma
        exec startplasma-x11
        # Using wayland
        # XDG_SESSION_TYPE=wayland dbus-run-session startplasma-wayland
        ;;
    *)
        export DESKTOP_SESSION=plasma
        exec startplasma-x11
        ;;
esac
# vim: ft=sh ts=4 sw=4 tw=0 fdm=marker foldlevel=0 :
