{ pkgs, ... }:

{
  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
  };

  home.file = {
    # Configuration for gamemode, for running games with optimizations.
    ".config/gamemode.ini".source = ./programs/gamemode.ini;

    # Configuration for mako, a notification daemon.
    ".config/mako".source = ./programs/mako;

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
      dxvk.enableGraphicsPipelineLibrary = True

      dxvk.enableAsync = True
    '';

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
    "video/mp4" = [ "vlc.desktop" ];
    "video/x-matroska" = [ "vlc.desktop" ];
    "x-scheme-handler/about" = [ "firefox.desktop" ];
    "x-scheme-handler/http" = [ "firefox.desktop" ];
    "x-scheme-handler/https" = [ "firefox.desktop" ];
    "x-scheme-handler/unknown" = [ "firefox.desktop" ];
  };
}
