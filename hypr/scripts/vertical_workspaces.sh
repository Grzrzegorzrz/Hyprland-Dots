#!/bin/sh

window=$(hyprctl activewindow)

layer=$(hyprctl activewindow \
      | grep special:vertical \
      | awk -F '.' '{print substr($NF, 1, length($NF)-1)}')

if [ $1 == "--move" ]; then
  move=true
  shift
fi

next_layer=$((layer + $1))
echo $next_layer

if [ "$move" == true ]; then
  if [ $next_layer -eq 0 ] || [ "$window" == "Invalid" ]; then
    hyprctl dispatch movetoworkspace $(($(hyprctl activeworkspace | awk '{print $3}')))
  else
    hyprctl dispatch movetoworkspace "special:vertical.$next_layer"
  fi

else
  if [ $next_layer -eq 0 ] || [ "$window" == "Invalid" ]; then
    hyprctl dispatch togglespecialworkspace void
    hyprctl dispatch togglespecialworkspace void
  else
    hyprctl dispatch togglespecialworkspace "vertical.$next_layer"
  fi
fi

