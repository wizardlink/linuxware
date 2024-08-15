{ pkgs, ... }:

{
  #
  ## HOME CONFIGURATION #
  #

  # Import configurations for better modularity.
  imports = [
    ./programs/alacritty.nix
    ./programs/emacs
    ./programs/fish
    ./programs/git.nix
    ./programs/hyprland
    ./programs/mangohud.nix
    ./programs/neovim
    ./programs/obs-studio.nix
    ./programs/rofi
    ./programs/spotify
    ./programs/tmux
    ./programs/waybar.nix
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "wizardlink";
  home.homeDirectory = "/home/wizardlink";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/wizardlink/etc/profile.d/hm-session-vars.sh
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    EDITOR = "nvim";

    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  ##
  ## PACKAGES #
  ##

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    brightnessctl
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
    wineWowPackages.stagingFull
    winetricks

    # Games
    mindustry-wayland
    prismlauncher
    shattered-pixel-dungeon
    xonotic

    ## Libraries
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    rnnoise-plugin
    xwaylandvideobridge

    ## Development
    lazygit

    ## Desktop environment
    cliphist
    grim
    mako
    polkit-kde-agent
    slurp
    swww

    ## Theming
    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "NerdFontsSymbolsOnly"
      ];
    })
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

  #
  ## DOTFILES #
  #

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Cattpuccin theme for fish shell.
    ".config/fish/themes/Catppuccin-Frappe.theme".source = ./programs/fish/Catppuccin-Frappe.theme;

    # Configuration for gamemode, for running games with optimizations.
    ".config/gamemode.ini".source = ./programs/gamemode.ini;

    # Configuration for mako, a notification daemon.
    ".config/mako".source = ./programs/mako;

    ## Kvantum's theme configuration.
    ".config/Kvantum/Catppuccin-Frappe-Lavender" = {
      source = "${
        pkgs.catppuccin-kvantum.override {
          accent = "Lavender";
          variant = "Frappe";
        }
      }/share/Kvantum/Catppuccin-Frappe-Lavender";
    };

    ".config/Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Catppuccin-Frappe-Lavender
    '';
    ##

    ## Themeing configuration for qt5 and qt6
    ".config/qt5ct/colors".source = ./theming/qt5ct;

    ".config/qt6ct/colors".source = ./theming/qt5ct; # We use the qt5ct because it's the SAME spec
    ##

    # Configure pipewire for microphone noise supression.
    ".config/pipewire/pipewire.conf.d/99-input-denoising.conf".text = ''
      context.modules = [
        { name = libpipewire-module-filter-chain
          args = {
            node.description =  "Noise Canceling source"
            media.name =  "Noise Canceling source"
            filter.graph = {
              nodes = [
                {
                  type = ladspa
                  name = rnnoise
                  plugin = ${pkgs.rnnoise-plugin}/lib/ladspa/librnnoise_ladspa.so
                  label = noise_suppressor_mono
                  control = {
                    "VAD Threshold (%)" = 60.0
                    "VAD Grace Period (ms)" = 175
                    "Retroactive VAD Grace (ms)" = 50
                  }
                }
              ]
            }
            capture.props = {
              node.name =  "capture.rnnoise_source"
              node.passive = true
              audio.rate = 48000
            }
            playback.props = {
              node.name =  "rnnoise_source"
              media.class = Audio/Source
              audio.rate = 48000
            }
          }
        }
      ]
    '';

    # Configure DXVK
    ".config/dxvk.conf".text = ''
      dxgi.tearFree = True
      dxvk.enableGraphicsPipelineLibrary = Auto

      dxvk.enableAsync = True
    '';

    ".local/share/SpeedCrunch/color-schemes/catppuccin-frappe.json" = {
      recursive = true;
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/speedcrunch/34f2b382de0188d2fd85f59a8a366f313fc30a71/themes/catppuccin-frappe.json";
        sha256 = "sha256:0imx5a53p3ls5kddplgr7mbpbidrmzl9qiwpv7r8jjmsf8yxs0i4";
      };
    };

    # My utility scripts
    ".local/share/scripts" = {
      source = ./scripts;
      recursive = true;
    };
  };

  ## Theming
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeLavender;
    name = "catppuccin-frappe-lavender-cursors";

    gtk.enable = true;
    x11.enable = true;
  };

  # Configure GTK.
  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "violet"; };
    };
  };

  # Configure QT
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };

  # Configure XDG
  xdg.mimeApps.defaultApplications = {
    "inode/directory" = [ "thunar.desktop" ];
    "text/html" = [ "firefox.desktop" ];
    "video/mp4" = [ "vlc.desktop" ];
    "video/x-matroska" = [ "vlc.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
  };
}
