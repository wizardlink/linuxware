pkgs:

pkgs.writeShellScriptBin "start_services" ''
  #
  # Make sure xdg-desktop-portal-hyprland has access to what it needs
  #
  dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

  #
  # Start waybar.
  #
  waybar &


  #
  # Start wallpaper daemon
  #
  ~/.local/share/scripts/wallpaper.sh &

  #
  # Start notification daemon.
  #
  mako &

  #
  # Start polkit agent
  #
  ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1 &

  #
  # Start kwallet service
  #
  kwalletd6 &

  #
  # Start kdeconnect daemon
  #
  kdeconnectd &

  #
  # Start Fcitx5
  #
  fcitx5 &

  #
  # Start the blueman applet for managing bluetooth devices
  #
  blueman-applet &

  #
  # Clipboard manager
  #
  ${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store &

  #
  # Service that syncs X11 and Wayland clipboards
  #
  clipboard-sync
''
