pkgs:

pkgs.writeShellScriptBin "start_apps" ''
  # Open qbittorrent
  qbittorrent &

  # Open vesktop
  vesktop &

  # Open steam
  steam &

  # Open firefox
  firefox
''
