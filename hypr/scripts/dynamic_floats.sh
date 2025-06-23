#!/bin/sh

# script that allows for multiple seperate instances of a floating temporary
# screenshot using hyprshot + feh. Make sure feh has a floating window rule:
  # windowrulev2 = float, class:^(feh)$

# this rule is recommended
  # windowrulev2 = move onscreen cursor -100% -100%, class:^(feh)$


# create /Pictures/.float_images/ if non existent
if [ ! -d ~/Pictures/.float_images ]; then
  mkdir -p ~/Pictures/.float_images
fi

index=0

# set index to the lowest number avaliable
while [ -f ~/Pictures/.float_images/float_$index.png ]; do
  ((index++))
done

hyprshot -m region -f "/.float_images/float_$index.png"

# wait for image to exist
if [ ! -f ~/Pictures/.float_images/float_$index.png ]; then
  sleep 0.05
fi

feh --auto-zoom --scale-down ~/Pictures/.float_images/float_$index.png

# terminate script on closing the feh instance
trap "rm ~/Pictures/.float_images/float_$index.png" EXIT
