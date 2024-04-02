#!/bin/bash

export _JAVA_AWT_WM_NONREPARENTING=1
export WLR_NO_HARDWARE_CURSORS=1
export QT_QPA_PLATFORM=wayland

eval $(ssh-agent)
sway --unsupported-gpu
