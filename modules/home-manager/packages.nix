{ pkgs, clipboard-sync, ... }:

{
  imports = [
    ./programs
  ];

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    ## Tools
    # Utilities
    fastfetch
    firefox
    pavucontrol
    protonvpn-gui
    qbittorrent
    qdirstat
    speedcrunch
    vlc
    yt-dlp
    zathura

    # Personal utilities
    anki
    ledger
    vesktop

    # Editing
    libreoffice

    # Creative work
    blender
    krita
    lmms
    orca-slicer
    shotcut
    vcv-rack

    ## Entertainment
    jellyfin-media-player

    # Gaming
    protontricks
    wineWowPackages.unstableFull
    winetricks

    # Games
    openttd
    prismlauncher
    shattered-pixel-dungeon
    xonotic

    ## Libraries
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    rnnoise-plugin

    ## Development
    beekeeper-studio
    hoppscotch
    lazygit

    ## Desktop environment
    clipboard-sync.packages.${pkgs.stdenv.hostPlatform.system}.default
    cliphist
    grim
    libsForQt5.ark
    loupe
    mako
    slurp
    swww

    # Mail client
    thunderbird
  ];
}
