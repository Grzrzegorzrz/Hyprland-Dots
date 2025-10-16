#!/bin/bash

# symlinked to home directory

if [ -n "$YAZI_LEVEL" ]; then
  duck=""

  for ((i=0; i<YAZI_LEVEL; i++)); do
    duck="${duck}󰇥"
  done

  PS1=" $duck $PS1"
fi
