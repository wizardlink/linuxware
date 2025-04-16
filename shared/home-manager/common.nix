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

    # Configuration for mako, a notification daemon.
    ".config/mako".source = ./dotfiles/mako;

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
    aseprite
    blender
    krita
    self.packages.${system}.lmms
    orca-slicer
    shotcut
    vcv-rack
    vhs

    ## Entertainment
    jellyfin-media-player

    ## Libraries
    libsForQt5.kdegraphics-thumbnailers
    libsForQt5.kio-extras
    rnnoise-plugin

    ## Development
    dbeaver-bin
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
