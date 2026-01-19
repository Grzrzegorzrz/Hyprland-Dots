#!/bin/sh

# handles xdg file opening actions
# urls go to browser instance

# this script is symlinked to /usr/share/applications/ and called by your
# .desktop file of choice

url=$1

# binaries; set to whatever binary you use
browser=/opt/zen-browser-bin/zen-bin
spotify=/opt/spotify/spotify
# spotify=/bin/spotify
# spotify="/usr/bin/flatpak run com.spotify.Client"

# convert spotify.link into open.spotify.com
case "$url" in
  *spotify.link*)
    url="$(curl -Ls -o /dev/null -w %\{url_effective\} "$1")"
    ;;
esac

# open spotify
case "$url" in
  *open.spotify.com*)
    hyprctl dispatch workspace special:spotify
    exec $spotify "$url"
    ;;
esac

# open new window on vertical.1 if nothing on vertical.1
if [ "$(hyprctl dispatch workspace special:vertical.1 > /dev/null;
        hyprctl activewindow)" = "Invalid" ]; then
  exec $browser --new-window "$url"

# open in existing vertical.1 zen window
else
  exec $browser "$url"
fi
