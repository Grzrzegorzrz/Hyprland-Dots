#!/bin/sh

# script that allows for multiple seperate instances of a floating temporary
# screenshot using hyprshot + feh. Make sure feh has a floating window rule:
  # windowrulev2 = float, class:^(feh)$

# this rule is recommended
  # windowrulev2 = move onscreen cursor -100% -100%, class:^(feh)$


# create /Pictures/.float_images/ if non existent
if [ ! -d $HOME/Pictures/.float_images ]; then
  mkdir -p $HOME/Pictures/.float_images
fi

index=0

# set index to the lowest number avaliable
while [ -f $HOME/Pictures/.float_images/float_$index.png ]; do
  ((index++))
done

flameshot gui -s -p "$HOME/Pictures/.float_images/float_$index.png"

# wait for image to exist
while [ ! -f $HOME/Pictures/.float_images/float_$index.png ]; do
  sleep 0.01
done
# wait for image to finish rendering
while ! cmp -s "$HOME/Pictures/.float_images/float_$index.png" "$HOME/Pictures/.float_images/float_$index.png"; do
  sleep 0.01
done

feh --auto-zoom --scale-down $HOME/Pictures/.float_images/float_$index.png

# remove file upon closing the feh instance
trap "rm $HOME/Pictures/.float_images/float_$index.png" EXIT
