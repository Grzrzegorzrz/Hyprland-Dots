#!/bin/sh

# helper script for moving window to special workspaces

output="$(hyprctl dispatch 'hl.dsp.window.move({ workspace = "r+0" })')"

if [ "$output" = "ok" ]; then
  if [ "$#" -eq 0 ]; then
    hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:special" })'
  fi

  while getopts 'dtsveug' flag; do
    case $flag in
      d)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:discord" })'
      ;;
      u)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:email" })'
      ;;
      s)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:spotify" })'
      ;;
      v)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:vertical" })'
      ;;
      e)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:e" })'
      ;;
      t)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:top" })'
      ;;
      g)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:background" })'
      ;;
      *)
        hyprctl dispatch 'hl.dsp.window.move({ workspace = "special:special" })'
      ;;
    esac
  done
fi
