#!/bin/sh

# handles xdg file opening actions
# urls go to browser instance

# this script is symlinked to /usr/share/applications/ and called by your
# .desktop file of choice

url=$1

browser_class="zen" # can be found via `hyprctl activewindow`
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

# open vertical.1 workspace
hyprctl dispatch workspace special:vertical.1

# open new window on vertical.1 if no browser on vertical.1
# (parse hyprctl clients for data on windows containing "vertical.1")
# (then grep for "class: zen")
if ! hyprctl clients \
   | awk -v RS= '/special:vertical\.1/' \
   | grep "class: $browser_class"; then

  exec $browser --new-window "$url"

# else open normally
else
  exec $browser "$url"
fi
