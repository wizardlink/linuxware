{ config, pkgs, custom-neovim, ... }:

{
  #
  ## HOME CONFIGURATION #
  #

  # Import configurations for better modularity.
  imports = [
    ./programs/fish
    ./programs/git.nix
    ./programs/hyprland
    ./programs/mangohud.nix
    ./programs/neovim
    ./programs/obs-studio.nix
    ./programs/rofi
    ./programs/waybar.nix
    ./programs/wezterm
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
    discord
    element-desktop
    firefox
    pavucontrol
    pulseaudio
    qbittorrent
    tigervnc
    vesktop
    vlc
    yt-dlp
    zathura

    # Editing
    krita
    libreoffice
    logseq
    shotcut

    ## Entertainment
    jellyfin-media-player
    spotify

    # Gaming
    dolphin-emu
    path-of-building
    protontricks
    vkbasalt
    winePackages.stableFull
    winetricks
    xonotic

    ## Libraries
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    rnnoise-plugin
    xwaylandvideobridge

    ## Development
    lazygit
    neofetch
    vscode-extensions.vadimcn.vscode-lldb

    ## Desktop environment
    cliphist
    grim
    mako
    polkit-kde-agent
    slurp
    swww

    ## Theming
    (nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qtwayland

    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (let base = pkgs.appimageTools.defaultFhsEnvArgs;
    in pkgs.buildFHSUserEnv (base // {
      name = "fhs";
      targetPkgs = pkgs:
        (
          # pkgs.buildFHSUserEnv provides only a minimal FHS environment,
          # lacking many basic packages needed by most software.
          # Therefore, we need to add them manually.
          #
          # pkgs.appimageTools provides basic packages required by most software.
          (base.targetPkgs pkgs) ++ (with pkgs; [ nodejs ]));
      profile = "export FHS=1";
      runScript = "bash";
      extraOutputsToInstall = [ "dev" ];
    }))
  ];

  #
  ## DOTFILES #
  #

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # Cattpuccin theme for fish shell.
    ".config/fish/themes/Catppuccin-Frappe.theme".source =
      ./programs/fish/Catppuccin-Frappe.theme;

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

    ".config/qt6ct/colors".source =
      ./theming/qt5ct; # We use the qt5ct because it's the SAME spec
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

    # My utility scripts
    ".local/share/scripts".source = ./scripts;
  };

  ## Theming
  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeLavender;
    name = "Catppuccin-Frappe-Lavender-Cursors";

    gtk.enable = true;
    x11 = {
      enable = true;
      defaultCursor = "Catppuccin-Frappe-Lavender-Cursors";
    };
  };

  # Configure GTK.
  gtk = {
    enable = true;

    theme = {
      name = "Catppuccin-Frappe-Lavender";
      package = pkgs.catppuccin-gtk.override {
        accents = [ "lavender" ];
        tweaks = [ "rimless" ];
        variant = "frappe";
      };
    };

    iconTheme = {
      name = "Papirus";
      package = pkgs.catppuccin-papirus-folders.override {
        accent = "lavender";
        flavor = "frappe";
      };
    };
  };

  # Configure QT
  qt = {
    enable = true;
    platformTheme = "qtct";
  };

  # Configure XDG
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox";
    "video/x-matroska" = "vlc";
    "x-scheme-handler/about" = "firefox";
    "x-scheme-handler/http" = "firefox";
    "x-scheme-handler/https" = "firefox";
    "x-scheme-handler/unknown" = "firefox";
  };

  systemd.user.services = {
    palserver = {
      Unit = { Description = "Palworld Server"; };

      Service = {
        ExecStart =
          "/etc/profiles/per-user/wizardlink/bin/fhs -c 'EpicApp=PalServer ./PalServer.sh -useperfthreads -NoAsyncLoadingThread -UseMultithreadForDS'";
        Restart = "always";
        #RuntimeMaxSec = "4h";
        Type = "simple";
        WorkingDirectory = "/mnt/ssd/Games/Steam/steamapps/common/PalServer";
      };

      Install = { WantedBy = [ "default.target" ]; };
    };

    foundry = {
      Unit = { Description = "FoundryVTT server"; };

      Service = {
        ExecStart =
          "/etc/profiles/per-user/wizardlink/bin/fhs -c 'node ./resources/app/main.js'";
        Restart = "on-failure";
        Type = "simple";
        WorkingDirectory = "/mnt/ssd/Games/FoundryVTT/FoundryProgram";
      };

      Install = { WantedBy = [ "default.target" ]; };
    };
  };
}
