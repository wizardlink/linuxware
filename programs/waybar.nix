{ ... }:
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        margin = "10px 10px 0";
        height = 30;

        modules-left = [
          "hyprland/workspaces"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "network"
          "memory"
          "cpu"
          "temperature"
          "battery"
          "hyprland/language"
          "tray"
        ];

        "hyprland/workspaces" = {
          format = "{icon}";

          format-icons = {
            active = "";
            default = "";
            empty = "";
            persistent = "";
            special = "";
            urgent = "";
          };
        };

        clock = {
          format = "{:%H:%M} ";
          format-alt = "{:%A; %B %d, %Y (%R)} ";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            on-click-right = "mode";
            format = {
              months = "<span color='#e5c890'><b>{}</b></span>";
              days = "<span color='#c6d0f5'><b>{}</b></span>";
              weeks = "<span color='#81c8be'><b>W{}</b></span>";
              weekdays = "<span color='#ef9f76'><b>{}</b></span>";
              today = "<span color='#a6d189'><b><u>{}</u></b></span>";
            };
            actions = {
              on-click-backward = "tz_down";
              on-click-forward = "tz_up";
              on-click-right = "mode";
              on-scroll-down = "shift_down";
              on-scroll-up = "shift_up";
            };
          };
        };

        network = {
          interval = 5;
          format = "  {bandwidthUpBits} 󰇙 {bandwidthDownBits} ";
          format-disconnected = " No connection";
          tooltip-format-wifi = " {essid} ({signalStrength}%)";
        };

        memory = {
          interval = 5;
          format = " {percentage}%";
          states = {
            warning = 70;
            critical = 90;
          };
          "tooltip-format" = "  {used:0.1f}G/{total:0.1f}G";
        };

        cpu = {
          interval = 5;
          tooltip = false;
          format = " {usage}%";
          format-alt = " {load}";
          states = {
            warning = 70;
            critical = 90;
          };
        };

        temperature = {
          critical-threshold = 90;
          interval = 5;
          format = "{icon} {temperatureC}°";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        # Module configuration
        battery = {
          interval = 10;
          states = {
            warning = 30;
            critical = 15;
          };

          format-time = "{H}:{M:02}";
          format = "{icon} {capacity}% ({time})";
          format-charging = " {capacity}% ({time})";
          format-charging-full = " {capacity}%";
          format-full = "{icon} {capacity}%";
          format-alt = "{icon} {power}W";
          format-icons = [
            ""
            ""
            ""
            ""
            ""
          ];
          tooltip = false;
        };

        "hyprland/language" = {
          format = "  {}";
          format-en = "EN/US";
          format-pt-br = "PT/BR";
          #"on-click" = "hyprctl switchxkblayout www.hfd.cn-monsgeek-keyboard-1 next";
          tooltip = false;
        };

        tray = {
          icon-size = 18;
          spacing = 10;
        };
      };
    };

    style = ''
      /* Using https://github.com/catppuccin/catppuccin for color reference. */

      /* Keyframes */
      @keyframes blink-critical {
        to {
          /*color: @white;*/
          background-color: @critical;
        }
      }

      * {
        all: unset;
        color: #c6d0f5;
        font-family: "FantasqueSansM Nerd Font", 'Courier New', Courier, monospace;
        font-size: 16px;
      }

      .modules-left,
      .modules-right,
      .modules-center {
        padding: 0 20px;
        border-radius: 10px;
        background-color: rgba(48, 52, 70, 0.85);
      }

      tooltip {
        background-color: rgba(48, 52, 70, 0.85);
        border-radius: 10px;
        padding: 8px;
      }

      tooltip label {
        color: #c6d0f5;
      }

      #workspaces {
        margin-left: -5px;
        padding-left: 0px;
      }

      #workspaces button {
        margin: 0 8px;
      }

      #workspaces button:hover {
        background: #414559;
        border: none;
      }

      #clock {
        padding: 0 10px;
      }

      #network, #cpu, #memory, #language, #temperature {
        margin: 0 8px;
      }

      #tray {
        margin-left: 8px;
      }

      #tray menu {
        background-color: rgba(48, 52, 70, 0.85);
        border-radius: 10px;
        padding: 8px;
      }
    '';
  };
}
