{ pkgs, ... }:

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
    xwaylandvideobridge

    ## Development
    beekeeper-studio
    lazygit

    ## Desktop environment
    cliphist
    grim
    libsForQt5.ark
    mako
    slurp
    swww

    # Mail client
    thunderbird

    ## Theming
    (nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "NerdFontsSymbolsOnly"
      ];
    })
    ibm-plex
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qtwayland

    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (
      let
        base = appimageTools.defaultFhsEnvArgs;
      in
      buildFHSUserEnv (
        base
        // {
          name = "fhs";
          targetPkgs =
            pkgs:
            (
              # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
              # lacking many basic packages needed by most software.
              # Therefore, we need to add them manually.
              #
              # pkgs.appimageTools provides basic packages required by most software.
              (base.targetPkgs pkgs) ++ (with pkgs; [ nodejs ])
            );
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];
}
