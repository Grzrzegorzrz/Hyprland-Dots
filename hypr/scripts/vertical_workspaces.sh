#!/bin/sh

# TODO: edgecase: persistent temp workspace int when unexpected switch from
#                 vertical workspace, which becomes an issue when switching
#                 back from an empty base workspace
#           - possible soln: 'hyprctl activeworkspace' gives output for focused
#                            blank workspaces, while 'hyprctl clients' only
#                            gives non blank workspaces
 
# bunch of spaghetti... will clean eventually

# temp file line:
#   1 -> current workspace
#   2 -> upper bound for workspaces

# behavior:
# - going up will toggle the above workspace if it is within bounds. else cycle
# - going downwards will toggle downwards, or cycle if on normal workspace
# - moving a window upwards will move it upwards. else cycle
# - moving a window downwards will move it downards, or cycle to a new
#   workspace above the current up-most if currently on normal workspace
# - vertical workspace 1 is persistent

temp=~/.config/hypr/scripts/vertical_temp

if [ ! -f $temp ]; then
  printf "0" >> $temp
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
  upper=0
fi

if [ $1 == "--move" ]; then
  move=true
  shift
fi

if [ "$window" == "Invalid" ]; then
  layer=$(($(cat $temp)))
fi
if [ $(($layer)) -gt $upper ]; then
  next_layer=$upper
else
  next_layer=$(($layer + $1))
fi

# if past upper bound
if [ $next_layer -gt $(($upper)) ] && [ ! "$next_layer" == "1" ]; then
    next_layer=0
fi

# cycle downwards
if [ "$next_layer" == "-1" ]; then
  if [ "$upper" == "0" ]; then
    next_layer=$(($upper+1))

  else
    next_layer=$(($upper))

    if [ "$move" == true ]; then
      next_layer=$(($next_layer+1))
    fi
  fi
fi

# change or move to next workspace
if [ $next_layer -eq 0 ]; then

  if [ "$move" == true ]; then
    hyprctl dispatch movetoworkspace $(($(hyprctl activeworkspace | awk 'NR==1 {print $3}')))
    echo "condition: zeroth + move"
  else
    hyprctl dispatch togglespecialworkspace void
    hyprctl dispatch togglespecialworkspace void
    echo "condition: zeroth"
  fi

  echo 0 > $temp

else
  if [ "$move" == true ]; then
    hyprctl dispatch movetoworkspace "special:vertical.$next_layer"
    echo "condition: vertical + move"
  else
    hyprctl dispatch togglespecialworkspace "vertical.$next_layer"
    echo "condition: vertical"
  fi

  echo $next_layer > $temp
fi

echo "next_layer: $next_layer"
echo "upper: $upper"
echo "current workspace: $(cat $temp)"
