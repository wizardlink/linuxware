#!/bin/sh

#
# Make sure xdg-desktop-portal-hyprland has access to what it needs
#
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

#
# Start waybar.
#
waybar &

#
# Start xwaylandvideobridge
#
xwaylandvideobridge &


#
# Start wallpaper daemon
#
~/.local/share/scripts/wallpaper.sh &

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
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &

#
# Start Fcitx5
#
fcitx5 &

#
# Start the blueman applet for managing bluetooth devices
#
blueman-applet &
