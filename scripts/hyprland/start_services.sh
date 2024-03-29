#!/bin/sh

#
# Make sure xdg-desktop-portal-hyprland has access to what it needs
#
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

#
# Start authentication polkit.
#
/nix/store/$(ls -la /nix/store | rg '^d.*polkit-kde-agent.*\d$' | awk '{print $9}')/libexec/polkit-kde-authentication-agent-1 &

#
# Start waybar.
#
waybar &

#
# Start xwaylandvideobridge
#
xwaylandvideobridge &

#
# Start fcitx5
#
fcitx5 &

#
## Start wallpaper daemon and set one.
#
OUTPUT_1="DP-2"
IMAGE_1="/mnt/internal/personal/wallpapers/wallhaven-z8e3wo.png"

OUTPUT_2="DP-3"
IMAGE_2="/mnt/internal/personal/wallpapers/wallhaven-g7ze63.jpg"

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
# Refresh kdeconnect connections
#
kdeconnect-cli --refresh &

#
# Clipboard manager
#
wl-paste -w cliphist store &

 # Need this to be able to paste in xwayland applications.
wl-paste -t text -w sh -c 'xclip -selection clipboard -o > /dev/null 2> /dev/null || xclip -selection clipboard'
