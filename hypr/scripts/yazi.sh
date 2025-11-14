#!/bin/sh

# symlinked to home directory

if [ -n "$YAZI_LEVEL" ]; then
  duck=""

  i=0
  while [ $i -lt "$YAZI_LEVEL" ]; do
    duck="${duck}󰇥"
    i=$((i+1))
  done

  PS1=" $duck $PS1"
fi
