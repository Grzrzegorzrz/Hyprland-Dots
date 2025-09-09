#!/bin/sh

# bunch of spaghetti... will clean eventually

# temp file line:
#   1 -> current workspace
#   2 -> upper bound for workspaces

temp=~/.config/hypr/scripts/vertical_temp

if [ ! -f $temp ]; then
  printf "0\n1" >> $temp
fi

window=$(hyprctl activewindow)

layer=$(hyprctl activewindow \
      | grep special:vertical \
      | awk -F '.' '{print substr($NF, 1, length($NF)-1)}')

# set upper bound
upper=$(hyprctl clients -j \
           | jq -r '.[] 
                  | select(.workspace.name
                  | startswith("special:vertical")) 
                  | .workspace.name' \
           | awk -F '.' '{print substr($NF, 1, length($NF))}' \
           | sort -u \
           | tail -n 1
)
if [ "$upper" == "" ]; then
  upper=1
fi
sed -i "2s/.*/$upper/" $temp

if [ $1 == "--move" ]; then
  move=true
  shift
fi

if [ "$window" == "Invalid" ]; then
  next_layer=$(($(head -n 1 $temp) + $1))
else
  next_layer=$(($layer + $1))
fi

if [ "$next_layer" == "-1" ]; then
  next_layer=$(($upper))
fi

# if past upper bound
if [ "$next_layer" == "$(($upper + 1))" ]; then
  if [ "$move" == true ]; then
    sed -i "2s/.*/$(($next_layer))/" $temp
  else
    next_layer=0
  fi
fi

# change or move to next workspace
if [ $next_layer -eq 0 ]; then

  if [ "$move" == true ]; then
    hyprctl dispatch movetoworkspace $(($(hyprctl activeworkspace | awk '{print $3}')))
    echo "condition: zeroth + move"
  else
    hyprctl dispatch togglespecialworkspace void
    hyprctl dispatch togglespecialworkspace void
    echo "condition: zeroth"
  fi

  sed -i "1s/.*/0/" $temp

else
  if [ "$move" == true ]; then
    hyprctl dispatch movetoworkspace "special:vertical.$next_layer"
    echo "condition: vertical + move"
  else
    hyprctl dispatch togglespecialworkspace "vertical.$next_layer"
    echo "condition: vertical"
  fi

  sed -i "1s/.*/$next_layer/" $temp
fi

echo "next_layer: $next_layer"
echo "upper: $upper"
echo "current workspace: $(head -n 1 $temp)"
echo "upperbound: $(tail -n 1 $temp)"
