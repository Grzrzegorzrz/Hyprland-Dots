#!/bin/bash

# handles xdg file opening actions
# urls go to browser instance

# this script is symlinked to /usr/share/applications/ and called by your
# .desktop file of choice

url=$1

# convert spotify.link into open.spotify.com
if [[ "$url" == *"spotify.link"* ]]; then
  url=$(curl -Ls -o /dev/null -w %{url_effective} "$1")
fi

# open spotify
if [[ "$url" == *"open.spotify.com"* ]]; then
  hyprctl dispatch workspace special:spotify

  # if binary is in opt
  if [[ -f /opt/spotify/spotify ]]; then
    /opt/spotify/spotify $url
  # if flatpak
  elif [[ -d /var/lib/flatpak/app/com.spotify.Client ]]; then
    exec /usr/bin/flatpak run com.spotify.Client $url
  # attempt to exec from /bin
  else
    /bin/spotify $url
  fi

# open new zen window on vertical.1 if nothing on vertical.1
elif [ "$(hyprctl dispatch workspace special:vertical.1 > /dev/null;
  hyprctl activewindow)" == "Invalid" ]; then
  /opt/zen-browser-bin/zen-bin --new-window $url

# open in existing vertical.1 zen window
else
  /opt/zen-browser-bin/zen-bin $url
fi
