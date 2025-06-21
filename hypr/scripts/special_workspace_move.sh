#!/bin/bash

output="$(hyprctl dispatch movetoworkspace "r+0")"

if [ "$output" = "Not moving to workspace because it didn't change." ]; then

  if (( $# == 0 )); then
    $(hyprctl dispatch movetoworkspace "special")
  fi

  while getopts 'dtsveu' flag; do
    case $flag in
      d)
        $(hyprctl dispatch movetoworkspace "special:discord")
      ;;
      u)
        $(hyprctl dispatch movetoworkspace "special:thunderbird")
      ;;
      s)
        $(hyprctl dispatch movetoworkspace "special:spotify")
      ;;
      b)
        $(hyprctl dispatch movetoworkspace "special:slack")
      ;;
      v)
        $(hyprctl dispatch movetoworkspace "special:vertical")
      ;;
      e)
        $(hyprctl dispatch movetoworkspace "special:e")
      ;;
      t)
        $(hyprctl dispatch movetoworkspace "special:top")
      ;;
      *)
        $(hyprctl dispatch movetoworkspace "special")
      ;;
    esac
  done
fi
