#!/bin/sh

window=$(hyprctl activewindow)
float=$(echo "$window" | grep floating | awk '{print $2}')

x=$(echo "$window" | grep at: | awk -F',|:' '{print $2}')
y=$(echo "$window" | grep at: | awk -F',|:' '{print $3}')

l1=$(echo "$window" | grep size: | awk -F',|:' '{print $2}')
h1=$(echo "$window" | grep size: | awk -F',|:' '{print $3}')

hyprctl dispatch togglefloating

if [ "$float" == "0" ]; then
  a=$(awk "BEGIN {print int($l1 * 0.8)}")
  b=$(awk "BEGIN {print int($h1 * 0.8)}")
  hyprctl dispatch resizeactive exact $a $b

  window=$(hyprctl activewindow)

  l2=$(echo "$window" | grep size: | awk -F',|:' '{print $2}')
  h2=$(echo "$window" | grep size: | awk -F',|:' '{print $3}')

  hyprctl dispatch moveactive exact $((x-(l2-l1)/2)) $((y-(h2-h1)/2))
else
  a=$(awk "BEGIN {print int($l1 * 1.25)}")
  b=$(awk "BEGIN {print int($h1 * 1.25)}")
  hyprctl dispatch resizeactive exact $a $b
fi
