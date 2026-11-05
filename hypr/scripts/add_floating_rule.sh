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

rule="hl.window_rule({ match = { class = [[^($class)$]], initial_title = [[^($initialTitle)$]] }, float = true })"

if ! grep -F "$rule" "$HOME/.config/hypr/window_rules_dynamic.lua" > /dev/null 2>&1; then
  hyprctl eval "$rule"
  echo "$rule" >> "$HOME/.config/hypr/window_rules_dynamic.lua"
fi
