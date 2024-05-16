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

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi


function xinit_run_programs {
    # Network manager applet
    nm-applet 2>&1 > /dev/null &

    # Bluetooth applet
    blueman-applet 2>&1 > /dev/null &

    # Pulseaudio applet
    pasystray &

    # Auto mounts USB to /media/
    udiskie --tray &

    # Auto lock screen
    xss-lock slock &

    # SSH agent
    eval $(ssh-agent)

    # Redshift for auto regulating screen colors temperature
    # redshift -l 49.26:-123.23 &
}

function setup_keyboard {
    # Enable switch CAPS LOCK - ESCAPE, restart X ctrl + alt + back, change keymap with both shifts
    setxkbmap -option caps:escape,terminate:ctrl_alt_bksp,grp:shifts_toggle es,us

    # Set repeat rate
    xset r rate 250 60
}

setup_keyboard

# Turns off the system bell
/usr/bin/xset b off
xsetroot -cursor_name left_ptr &

# Auto lower brightness
# xset -q (To check options)
# xset +dpms
# xset dpms 0 0 300

case $HOSTNAME in
    vbox-new-arch)
        # Running in a virtual machine
        VBoxClient-all
        export LIBGL_ALWAYS_SOFTWARE=1
        ;;
    arch-5900X)
        xrandr --output HDMI-0 --off --output DP-0 --primary --preferred --mode 2560x1440 --output DP-2 --mode 1920x1080 --right-of DP-0
        ;;
    *)
        # Auto configure displays
        DISPLAYS=($(xrandr -q | grep ' connected' | sed -e 's/\(.*\)connected.*/\1/g'))
        if [[ ${#DISPLAYS[@]} == 2 ]]; then
            xrandr --output ${DISPLAYS[@]:1:1} --primary --preferred --auto --left-of ${DISPLAYS[@]:0:1}
        fi
        ;;
esac

case $1 in
    bspwm)
        export XDG_CURRENT_DESKTOP=bspwm
        # Fix Java app issues
        export _JAVA_AWT_WM_NONREPARENTING=1 AWT_TOOLKIT=MToolkit
        xinit_run_programs
        # https://github.com/lxqt/lxqt-qtplugin#configuration-usage
        # export QT_QPA_PLATFORMTHEME=lxqt
        [ -f /usr/lib/pam_kwallet_init ] && /usr/lib/pam_kwallet_init

        pgrep -x sxhkd > /dev/null || sxhkd &
        clipit &
        picom &

		if [ -f /usr/lib/xfce4/notifyd/xfce4-notifyd ]; then
			/usr/lib/xfce4/notifyd/xfce4-notifyd &
        else
            dunst &
        fi

        # Set background using feh
        sh ~/.fehbg
        [ -f ~/.runonce ] && sh ~/.runonce

        exec bspwm
        ;;
    xfce4)
        xinit_run_programs
        pgrep -x sxhkd > /dev/null || sxhkd &
        exec startxfce4
        ;;
    lxqt)
        xinit_run_programs
        pgrep -x sxhkd > /dev/null || sxhkd &
        pgrep -x fbxkb > /dev/null || fbxkb &
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
    gnome)
        export XDG_SESSION_TYPE=x11
        export GDK_BACKEND=x11
        exec gnome-session
        ;;
    gnome-classic)
        export XDG_CURRENT_DESKTOP=GNOME-Classic:GNOME
        export GNOME_SHELL_SESSION_MODE=classic
        exec gnome-session
        ;;
    gnome-wayland)
        export XDG_SESSION_TYPE=wayland
        dbus-run-session gnome-session
        ;;
    *)
        export DESKTOP_SESSION=plasma
        exec startplasma-x11
        ;;
esac
# vim: ft=sh ts=4 sw=4 tw=0 fdm=marker foldlevel=0 :
