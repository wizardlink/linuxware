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
    (vesktop.override {
      # FIXME: Need to pin until https://github.com/NixOS/nixpkgs/issues/380429 gets resolved.
      electron = electron_33;
    })

    # Editing
    libreoffice

    # Creative work
    aseprite
    blender
    krita
    lmms
    orca-slicer
    shotcut
    vcv-rack
    vhs

    ## Entertainment
    jellyfin-media-player

    # Gaming
    gamescope
    heroic
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
    godot_4
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
