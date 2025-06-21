# mkdir .temp_install_env
# cd .temp_install_env

pacman --noconfirm -Sy --needed \
            base-devel foot yazi btop rofi-wayland waybar hypridle hyprlock \
            hyprpaper zoxide ouch fzf fd poppler ffmpeg zen-browser-bin

git clone https://github.com/MrOtherGuy/fx-autoconfig

# fx-autoconfig
# I could probably just contain this in the repo but I'm not sure about the
# licencing
rsync -av ./fx-autoconfig/program/* /opt/zen-browser-bin/
rm -rf  ./fx-autoconfig

# quickly generate a zen profile if non existent
zen-browser --headless & sleep 0.1; kill $(pgrep -x "zen-bin")

mv ./zen/chrome ~/.zen/"$(ls ~/.zen | grep Default)"/
rm -rf ./zen
rm -rf ./.cache/zen

# moving configs
if [ -d ~/.config/foot ]; then mv ~/.config/foot ~/.config/foot_backup; fi
if [ -d ~/.config/btop ]; then mv ~/.config/btop ~/.config/btop_backup; fi
if [ -d ~/.config/hypr ]; then mv ~/.config/hypr ~/.config/hypr_backup; fi
if [ -d ~/.config/rofi ]; then mv ~/.config/rofi ~/.config/rofi_backup; fi
if [ -d ~/.config/waybar ]; then mv ~/.config/waybar ~/.config/waybar_backup; fi
if [ -d ~/.config/yazi ]; then mv ~/.config/yazi ~/.config/yazi_backup; fi

mv install.sh .install.sh
mv ./* ~/.config
mv .install.sh install.sh

# yazi
echo ''' if [ -n "$YAZI_LEVEL" ]; then
  prefix=""

  for ((i=0; i<YAZI_LEVEL; i++)); do
    prefix="${prefix}󰇥"
  done

  PS1=" $prefix $PS1"
fi ''' >> ~/.yazi.sh
echo '''source ~/.yazi.sh''' >> ~/.bashrc

# zoxide
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc

# cd ..
# rm -rf .temp_install_env
