#!/bin/sh

# script that allows for multiple seperate instances of a floating temporary
# screenshot using hyprshot + feh. Make sure feh has a floating window rule:
  # windowrulev2 = float, class:^(feh)$

# this rule is recommended
  # windowrulev2 = move onscreen cursor -100% -100%, class:^(feh)$


dir=$HOME/Pictures/.float_images

# create /Pictures/.float_images/ if non existent
if [ ! -d $dir ]; then
  mkdir -p $dir
fi

index=0

# launch and bind all leftover floats on boot
if [ $1 == "leftover" ]; then
  if [ "$(ls -A "$dir")" ]; then
    for f in $dir/*; do
      (
        feh --auto-zoom --scale-down $f
        trap "rm "$f"" EXIT
      ) &
    done
  fi

  exit
fi

# set index to the lowest number avaliable
while [ -f $dir/float_$index.png ]; do
  ((index++))
done

out=$(flameshot gui -s -p "$dir/float_$index.png")

# terminate script if flameshot aborted
if [[ $out == *"abort"* ]]; then
  exit
fi

# wait for image to exist
while [ ! -f $dir/float_$index.png ]; do
  sleep 0.01
done
# wait for image to finish rendering
while ! cmp -s "$dir/float_$index.png" "$dir/float_$index.png"; do
  sleep 0.01
done

feh --auto-zoom --scale-down $dir/float_$index.png

# remove file upon closing the feh instance
trap "rm $dir/float_$index.png" EXIT
