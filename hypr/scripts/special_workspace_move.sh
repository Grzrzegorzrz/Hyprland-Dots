#!/bin/sh

# helper script for moving window to special workspaces

output="$(hyprctl dispatch movetoworkspace "r+0")"

if [ "$output" = "Not moving to workspace because it didn't change." ]; then
  if [ "$#" -eq 0 ]; then
    hyprctl dispatch movetoworkspace "special:special"
  fi

  while getopts 'dtsveug' flag; do
    case $flag in
      d)
        hyprctl dispatch movetoworkspace "special:discord"
      ;;
      u)
        hyprctl dispatch movetoworkspace "special:email"
      ;;
      s)
        hyprctl dispatch movetoworkspace "special:spotify"
      ;;
      v)
        hyprctl dispatch movetoworkspace "special:vertical"
      ;;
      e)
        hyprctl dispatch movetoworkspace "special:e"
      ;;
      t)
        hyprctl dispatch movetoworkspace "special:top"
      ;;
      g)
        hyprctl dispatch movetoworkspace "special:background"
      ;;
      *)
        hyprctl dispatch movetoworkspace "special:special"
      ;;
    esac
  done
fi
