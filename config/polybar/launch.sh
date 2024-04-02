#!/usr/bin/env bash

BAR_NAME=bar1
PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch on primary monitor
MONITOR=$PRIMARY polybar --reload $BAR_NAME &
# Wait for systray claimming
sleep 1

# Launch on all other monitors
for m in $OTHERS; do
    MONITOR=$m polybar --reload $BAR_NAME &
done
