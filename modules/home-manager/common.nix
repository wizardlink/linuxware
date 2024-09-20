{ pkgs, ... }:

{

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

    ".local/share/scripts/hyprland/start_services.sh" = {
      executable = true;
      text = # sh
        ''
          #!/bin/sh

          #
          # Make sure xdg-desktop-portal-hyprland has access to what it needs
          #
          dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &

          #
          # Start waybar.
          #
          waybar &

          #
          # Start xwaylandvideobridge
          #
          xwaylandvideobridge &


          #
          # Start wallpaper daemon
          #
          ~/.local/share/scripts/wallpaper.sh &

          #
          # Start notification daemon.
          #
          mako &

          #
          # Start polkit agent
          #
          ${pkgs.libsForQt5.polkit-kde-agent}/libexec/polkit-kde-authentication-agent-1

          #
          # Start kwallet service
          #
          kwalletd6 &

          #
          # Start kdeconnect daemon
          #
          kdeconnectd &

          #
          # Clipboard manager
          #
          wl-paste --type text --watch cliphist store &
          wl-paste --type image --watch cliphist store &

          #
          # Start Fcitx5
          #
          fcitx5 &

          #
          # Start the blueman applet for managing bluetooth devices
          #
          blueman-applet &
        '';
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
