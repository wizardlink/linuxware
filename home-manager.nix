{ pkgs, ... }:

{
  #
  ## HOME CONFIGURATION #
  #

  # Import configurations for better modularity.
  imports = [
    ./programs/fish
    ./programs/git.nix
    ./programs/mangohud.nix
    ./programs/neovim
    ./programs/obs-studio.nix
    ./programs/tmux
    ./programs/wezterm
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "yozawa";
  home.homeDirectory = "/home/yozawa";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/yozawa/etc/profile.d/hm-session-vars.sh
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

    # GNOME Stuff
    gnome-extension-manager
    gnome.gnome-tweaks

    # Utilities
    (pkgs.citrix_workspace_23_09_0.overrideAttrs (
      final: old: { buildInputs = old.buildInputs ++ [ pkgs.webkitgtk ]; }
    ))
    geekbench
    gparted
    fastfetch
    firefox
    obs-cmd
    losslesscut-bin
    sunshine
    qbittorrent
    quickemu
    vesktop
    xwaylandvideobridge
    yt-dlp
    zerotierone

    # Media Viewer
    feh
    mpv

    # Editing
    libreoffice

    ## Entertainment
    jellyfin-media-player

    # Gaming
    protontricks
    wineWowPackages.stagingFull
    winetricks

    ## Libraries
    rnnoise-plugin

    ## Theming
    (nerdfonts.override {
      fonts = [
        "FantasqueSansMono"
        "NerdFontsSymbolsOnly"
      ];
    })
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

  #
  ## THEMING #
  #

  # Prefer dark theme for GNOME/GTK4+.
  dconf = {
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  #
  ## MISC #
  #

  # Configure XDG
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox";
    "video/x-matroska" = "vlc";
    "x-scheme-handler/about" = "firefox";
    "x-scheme-handler/http" = "firefox";
    "x-scheme-handler/https" = "firefox";
    "x-scheme-handler/unknown" = "firefox";
  };
}
