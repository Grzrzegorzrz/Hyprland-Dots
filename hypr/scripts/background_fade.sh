#!/bin/sh

if [ "$(hyprctl getoption decoration:dim_special | awk 'NR==1{print $2}')" = "0.200000" ]; then
  hyprctl eval 'hl.config({ decoration = { dim_special = 0 } })'
else
  hyprctl eval 'hl.config({ decoration = { dim_special = 0.2 } })'
fi
