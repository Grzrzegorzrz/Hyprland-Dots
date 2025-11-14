#!/bin/sh

# script to toggle border decorations

if [ "$(hyprctl getoption decoration:dim_inactive | awk 'NR==1{print $2}')" = 0 ]; then
  # dimmed mode
  hyprctl keyword decoration:dim_inactive true

  hyprctl keyword general:border_size 0
  hyprctl keyword general:gaps_in 0
  hyprctl keyword general:gaps_out 1
else
  # bordered mode (default)
  hyprctl keyword decoration:dim_inactive false

  hyprctl keyword general:border_size 3
  hyprctl keyword general:gaps_in -1
  hyprctl keyword general:gaps_out 6
fi
