#!/bin/sh

class=$(hyprctl activewindow | grep class | awk '{print $NF}')
initialTitle=$(hyprctl activewindow | grep initialTitle | awk '{print $NF}')

if [ "$class" = "class:" ]; then
  class=""
fi

if [ "$initialTitle" = "initialTitle:" ]; then
  initialTitle=""
fi

rule="windowrulev2 = float, class:^($class)$, initialTitle:^($initialTitle)$" 

if [ ! $(grep -F '"$rule"' ~/.config/hypr/hyprland.conf) > /dev/null ]; then
  echo "$rule" >> ~/.config/hypr/hyprland.conf
fi
