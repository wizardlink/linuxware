pkgs:

pkgs.writeShellScriptBin "start_services" ''
  #
  # Make sure xdg-desktop-portal-hyprland has access to what it needs
  #
  dbus-update-activation-environment --systemd --all &

  #
  # Start Caelestia (quickshell)
  #
  uwsm app -- caelestia resizer -d &
  uwsm app -- caelestia shell -d &

  #
  # Start polkit agent
  #
  uwsm app -- ${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1 &

  #
  # Start kwallet service
  #
  uwsm app -- kwalletd6 &

  #
  # Start kdeconnect daemon
  #
  uwsm app -- kdeconnectd &

  #
  # Start Fcitx5
  #
  uwsm app -- fcitx5 &

  #
  # Start the blueman applet for managing bluetooth devices
  #
  uwsm app -- blueman-applet &

  #
  # Clipboard manager
  #
  uwsm app -- ${pkgs.wl-clipboard}/bin/wl-paste --watch cliphist store &

  #
  # Service that syncs X11 and Wayland clipboards
  #
  uwsm app -- clipboard-sync
''
