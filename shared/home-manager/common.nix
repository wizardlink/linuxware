{
  self,
  pkgs,
  clipboard-sync,
  ...
}:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.file = {
    # My utility scripts
    ".local/share/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };

  # Configure XDG
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "thunar.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "text/plain" = [ "nvim.desktop" ];
    "video/mp4" = [ "vlc.desktop" ];
    "video/x-matroska" = [ "vlc.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
  };

  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    ## Tools
    # Utilities
    cameractrls-gtk4
    fastfetch
    firefox
    pavucontrol
    proton-vpn
    qbittorrent
    qdirstat
    speedcrunch
    vlc
    yt-dlp
    zathura

    # Personal utilities
    # anki # FIXME: Broken
    ledger
    vesktop

    # Editing
    libreoffice

    # Creative work
    # aseprite
    # blender
    #krita
    # self.packages.${system}.lmms # FIXME: Broken for now, gotta update the package
    orca-slicer
    shotcut
    # vcv-rack

    ## Entertainment
    jellyfin-desktop

    ## Libraries
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kio-extras
    rnnoise-plugin

    ## Development
    # dbeaver-bin
    # godot_4
    # hoppscotch
    lazygit

    ## Desktop environment
    clipboard-sync.packages.${pkgs.stdenv.hostPlatform.system}.default
    cliphist
    grim
    kdePackages.ark
    loupe
    slurp

    # Mail client
    thunderbird
  ];
}
