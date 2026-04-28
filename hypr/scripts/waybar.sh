#!/bin/sh

# very hacky script that auto closes waybar after x seconds
# done to prevent burnin on oled monitors

timeout=10

# start waybar if not running
if ! pgrep -x "waybar" > /dev/null; then
  waybar &
  sleep $timeout
  killall -SIGUSR1 waybar
  exit 0
fi

# prematurely close waybar ui
if [ "$(pgrep -x 'waybar.sh' | wc -l)" -gt 2 ]; then
  killall -SIGUSR1 waybar
  killall -9 waybar.sh
fi

killall -SIGUSR1 waybar
sleep $timeout
killall -SIGUSR1 waybar
