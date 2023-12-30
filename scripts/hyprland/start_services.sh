#!/bin/sh

#
# Start waybar.
#
waybar &

#
## Start wallpaper daemon and set one.
#
OUTPUT_1="DP-2"
IMAGE_1="/mnt/internal/personal/wallpapers/wallhaven-g71xoe.jpg"

OUTPUT_2="DP-3"
IMAGE_2="/mnt/internal/personal/wallpapers/wallhaven-3zjexv.jpg"

function load_wallpapers() {
  swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 60 -o $OUTPUT_1 $IMAGE_1;
  swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 60 -o $OUTPUT_2 $IMAGE_2
}

if ! swww query; then
  swww init &
fi

load_wallpapers &

#
# Start notification daemon.
#
mako &

#
# Start authentication polkit.
#
/nix/store/$(ls -la /nix/store | rg '^d.*polkit-kde-agent.*\d$' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1 &

#
# Refresh kdeconnect connections
#
kdeconnect-cli --refresh &

#
# Clipboard manager
#
wl-paste -w cliphist store &

 # Need this to be able to paste in xwayland applications.
wl-paste -t text -w sh -c 'v=$(cat); cmp -s <(xclip -selection clipboard -o)  <<< "$v" || xclip -selection clipboard <<< "$v"' &
