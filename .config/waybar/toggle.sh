#!/bin/bash
#  _____                 _       __        __          _
# |_   _|__   __ _  __ _| | ___  \ \      / /_ _ _   _| |__   __ _ _ __
#   | |/ _ \ / _` |/ _` | |/ _ \  \ \ /\ / / _` | | | | '_ \ / _` | '__|
#   | | (_) | (_| | (_| | |  __/   \ V  V / (_| | |_| | |_) | (_| | |
#   |_|\___/ \__, |\__, |_|\___|    \_/\_/ \__,_|\__, |_.__/ \__,_|_|
#            |___/ |___/                         |___/
#

# toggle.sh — Toggle Waybar visibility or start it if not running

# Check if Waybar is running
if pgrep -x waybar > /dev/null; then
    # Send SIGUSR1 to toggle hide/show
    pkill -SIGUSR1 -x waybar
else
    # Launch Waybar in the background
    waybar &
fi

