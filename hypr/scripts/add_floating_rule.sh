#!/bin/sh

# allows for adding a window rule to make a window float using a keybind

class=$(hyprctl activewindow | grep class | awk '{print $NF}')
initialTitle=$(hyprctl activewindow | grep initialTitle | awk '{print $NF}')

if [ "$class" = "class:" ]; then
  class=""
fi

if [ "$initialTitle" = "initialTitle:" ]; then
  initialTitle=""
fi

rule="windowrulev2 = float, class:^($class)$, initialTitle:^($initialTitle)$" 

if [ ! $(grep -F '"$rule"' $HOME/.config/hypr/hyprland.conf) > /dev/null ]; then
  echo "$rule" >> $HOME/.config/hypr/window_rules.conf
fi
