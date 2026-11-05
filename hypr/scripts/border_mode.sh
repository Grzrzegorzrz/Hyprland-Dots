#!/bin/sh

# script to toggle border decorations

if [ "$(hyprctl getoption decoration:dim_inactive | awk 'NR==1{print $2}')" = "false" ]; then
  # dimmed mode
  hyprctl eval 'hl.config({ decoration = { dim_inactive = true } })'

  hyprctl eval 'hl.config({ general = { border_size = 0 } })'
  hyprctl eval 'hl.config({ general = { gaps_in = 0 } })'
  hyprctl eval 'hl.config({ general = { gaps_out = 1 } })'
else
  # bordered mode (default)
  hyprctl eval 'hl.config({ decoration = { dim_inactive = false } })'

  hyprctl eval 'hl.config({ general = { border_size = 3 } })'
  hyprctl eval 'hl.config({ general = { gaps_in = -1 } })'
  hyprctl eval 'hl.config({ general = { gaps_out = 6 } })'
fi
