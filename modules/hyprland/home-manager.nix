{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.modules.hyprland;
in
{
  options.modules.hyprland = {
    extraConfig = lib.mkOption {
      type = lib.types.str;
      default = "";
      example = # hyprlang
        ''
          monitor = DP-3, 1920x1080@74.973, 2560x0, 1
          monitor = DP-2, 2560x1440@165.00301, 0x0, 1
        '';
      description = "Configuration to be appended to my own.";
    };

    hypridle.enable = lib.mkEnableOption "hypridle";

    hyprlock = {
      enable = lib.mkEnableOption "hyprlock";
      background = lib.mkOption {
        type = lib.types.path;
        default = "";
        example = "~/wallpapers/abc.png";
        description = "The image to be used as background for hyprlock.";
      };
    };

    scripts = {
      screenshot.enable = lib.mkEnableOption "screenshot";
      startup.enable = lib.mkEnableOption "startup";
    };
  };

  config = {
    home.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      QT_QPA_PLATFORM = "wayland";
    };

    xdg.configFile."hypr/frappe.conf".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/hyprland/main/themes/frappe.conf";
      sha256 = "1clw669i1n3dhawdw4clmjv75fy3smycb5iqk3sanzpr3y0i4vwx";
    };

    # Enable hypridle and hyprlock
    services.hypridle = lib.mkIf cfg.hypridle.enable {
      enable = true;
      settings = {
        general = {
          after_sleep_cmd = "hyprctl dispatch dpms on";
          ignore_dbus_inhibit = false;
          lock_cmd = "hyprlock";
        };

        listener =
          [
            {
              timeout = 180;
              on-timeout = "hyprctl dispatch dpms off";
              on-resume = "hyprctl dispatch dpms on";
            }
          ]
          ++ lib.optionals cfg.hyprlock.enable [
            {
              timeout = 120;
              on-timeout = "hyprlock";
            }
          ];
      };
    };

    programs.hyprlock = lib.mkIf cfg.hyprlock.enable {
      enable = true;
      extraConfig = # hyprlang
        ''
          source = $HOME/.config/hypr/frappe.conf

          $accent = $mauve
          $accentAlpha = $mauveAlpha
          $font = JetBrainsMono Nerd Font

          # GENERAL
          general {
            disable_loading_bar = true
            hide_cursor = true
          }

          # BACKGROUND
          background {
            monitor =
            path = ${cfg.hyprlock.background}
            blur_passes = 0
            color = $base
          }

          # LAYOUT
          label {
            monitor =
            text = Layout: $LAYOUT
            color = $text
            font_size = 25
            font_family = $font
            position = 30, -30
            halign = left
            valign = top
          }

          # TIME
          label {
            monitor =
            text = $TIME
            color = $text
            font_size = 90
            font_family = $font
            position = -30, 0
            halign = right
            valign = top
          }

          # DATE
          label {
            monitor =
            text = cmd[update:43200000] date +"%A, %d %B %Y"
            color = $text
            font_size = 25
            font_family = $font
            position = -30, -150
            halign = right
            valign = top
          }

          # USER AVATAR
          image {
            monitor =
            path = $HOME/.face
            size = 100
            border_color = $accent
            position = 0, 75
            halign = center
            valign = center
          }

          # INPUT FIELD
          input-field {
            monitor =
            size = 300, 60
            outline_thickness = 4
            dots_size = 0.2
            dots_spacing = 0.2
            dots_center = true
            outer_color = $accent
            inner_color = $surface0
            font_color = $text
            fade_on_empty = false
            placeholder_text = <span foreground="##$textAlpha"><i>󰌾 Logged in as </i><span foreground="##$accentAlpha">$USER</span></span>
            hide_input = false
            check_color = $accent
            fail_color = $red
            fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
            capslock_color = $yellow
            position = 0, -47
            halign = center
            valign = center
          }
        '';
    };

    # Set-up the scripts for services and apps.
    home.packages = lib.mkIf cfg.scripts.startup.enable [
      (import ./scripts/start_services.nix pkgs)
    ];

    # Then add the hyprland screenshot scripts.
    xdg.dataFile = lib.mkIf cfg.scripts.screenshot.enable {
      "scripts/hyprland/screenshot.sh".source = ./scripts/screenshot.sh;
      "scripts/hyprland/screenshot_area.sh".source = ./scripts/screenshot_area.sh;
    };

    # Configure hyprland - we enable it in NixOS.
    xdg.configFile."hypr/hyprland.conf".text = # hyprlang
      ''
        source = $HOME/.config/hypr/frappe.conf
        ${cfg.extraConfig}

        #
        # Please note not all available settings / options are set here.
        # For a full list, see the wiki
        #

        autogenerated = 0 # remove this line to remove the warning

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more

        # Inject home-manager session variables
        exec-once = /etc/profiles/per-user/wizardlink/etc/profile.d/hm-session-vars.sh

        # Start the core services of my desktop
        exec-once = start_services

        # Set cursor size.
        exec-once = hyprctl setcursor 24
        env = XCURSOR_SIZE, 24

        # Source a file (multi-file configs)
        # source = ~/.config/hypr/myColors.conf

        # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
        input {
          kb_layout =
          kb_variant =
          kb_model =
          kb_options =
          kb_rules =

          follow_mouse = 1
          float_switch_override_focus = 1

          accel_profile = flat
          force_no_accel = true

          sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

          tablet {
            output = DP-2
          }
        }

        general {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          gaps_in = 6
          gaps_out = 18
          border_size = 2
          col.active_border = $base $surface0 $green 45deg
          col.inactive_border = $base $surface0 $blue 45deg

          layout = dwindle
        }

        decoration {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more

          rounding = 8

          blur {
            enabled = true
            size = 8
            passes = 1
            new_optimizations = true
          }

          shadow {
            enabled = true
            range = 4
            render_power = 3
            color = $crust
          }
        }

        animations {
          enabled = yes

          # Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

          bezier = myBezier, 0.05, 0.9, 0.1, 1.05

          animation = windows, 1, 7, myBezier
          animation = windowsOut, 1, 7, default, popin 80%
          animation = border, 1, 10, default
          animation = borderangle, 1, 8, default
          animation = fade, 1, 7, default
          animation = workspaces, 1, 6, default
        }

        dwindle {
          # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
          pseudotile = yes # master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          preserve_split = yes # you probably want this
        }

        master {
          # See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
          new_status = slave
        }

        gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
        }

        # Example windowrule v1
        # windowrule = float, ^(kitty)$
        # Example windowrule v2
        # windowrule = float,class:^(kitty)$,title:^(kitty)$
        # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

        # See https://wiki.hyprland.org/Configuring/Keywords/ for more
        $mainMod = SUPER

        # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
        bind = $mainMod CTRL, F, fullscreenstate, -1 2
        bind = $mainMod CTRL, L, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
        bind = $mainMod CTRL, P, exec, ~/.local/share/scripts/hyprland/screenshot_area.sh
        bind = $mainMod CTRL, V, pin
        bind = $mainMod SHIFT, F, fullscreen, 1
        bind = $mainMod SHIFT, P, exec, ~/.local/share/scripts/hyprland/screenshot.sh
        bind = $mainMod, C, killactive
        bind = $mainMod, E, exec, thunar
        bind = $mainMod, F, fullscreen
        bind = $mainMod, M, exit
        bind = $mainMod, O, togglesplit # dwindle
        bind = $mainMod, P, pseudo # dwindle
        bind = $mainMod, Q, exec, alacritty
        bind = $mainMod, R, exec, rofi -show drun
        bind = $mainMod, V, togglefloating

        # Move focus with mainMod + arrow keys
        bind = $mainMod, H, movefocus, l
        bind = $mainMod, L, movefocus, r
        bind = $mainMod, K, movefocus, u
        bind = $mainMod, J, movefocus, d

        # Switch workspaces with mainMod + [0-9]
        bind = $mainMod, 1, workspace, 1
        bind = $mainMod, 2, workspace, 2
        bind = $mainMod, 3, workspace, 3
        bind = $mainMod, 4, workspace, 4
        bind = $mainMod, 5, workspace, 5
        bind = $mainMod, 6, workspace, 6
        bind = $mainMod, 7, workspace, 7
        bind = $mainMod, 8, workspace, 8
        #bind = $mainMod, 9, workspace, 9
        #bind = $mainMod, 0, workspace, 10

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        bind = $mainMod SHIFT, 1, movetoworkspace, 1
        bind = $mainMod SHIFT, 2, movetoworkspace, 2
        bind = $mainMod SHIFT, 3, movetoworkspace, 3
        bind = $mainMod SHIFT, 4, movetoworkspace, 4
        bind = $mainMod SHIFT, 5, movetoworkspace, 5
        bind = $mainMod SHIFT, 6, movetoworkspace, 6
        bind = $mainMod SHIFT, 7, movetoworkspace, 7
        bind = $mainMod SHIFT, 8, movetoworkspace, 8
        bind = $mainMod SHIFT, 9, movetoworkspace, 9
        bind = $mainMod SHIFT, 0, movetoworkspace, 10

        # Scroll through existing workspaces with mainMod + scroll
        bind = $mainMod, mouse_down, workspace, e+1
        bind = $mainMod, mouse_up, workspace, e-1

        # Move/resize windows with mainMod + LMB/RMB and dragging
        bind = $mainMod SHIFT, H, movewindow, l
        bind = $mainMod SHIFT, L, movewindow, r
        bind = $mainMod SHIFT, K, movewindow, u
        bind = $mainMod SHIFT, J, movewindow, d
        bind = $mainMod ALT, H, resizeactive, -5% 0
        bind = $mainMod ALT, L, resizeactive, 5% 0
        bind = $mainMod ALT, K, resizeactive, 0 -5%
        bind = $mainMod ALT, J, resizeactive, 0 5%
        bindm = $mainMod, mouse:272, movewindow
        bindm = $mainMod, mouse:273, resizewindow

        # Volume changes
        binde = , XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%+
        binde = , XF86AudioLowerVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 1%-
        bind = , XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

        # Passthrough binds
        bind = SHIFT CTRL, F12, pass, class:^(com\.obsproject\.Studio)$

        # Window rules for xwaylandvideobridge
        windowrule = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
        windowrule = noanim,class:^(xwaylandvideobridge)$
        windowrule = nofocus,class:^(xwaylandvideobridge)$
        windowrule = noinitialfocus,class:^(xwaylandvideobridge)$

        # Rules for windowkill
        windowrule = tag +windowkill, class:^(steam_app_2726450)$
        windowrule = noborder, tag:windowkill
        windowrule = pin, tag:windowkill
        windowrule = opacity 0.9, tag:windowkill

        # Rules for Awakened PoE
        windowrule = tag +poe, class:^(steam_app_238960)$
        windowrule = allowsinput, tag:poe

        windowrule = tag +apt, class:^(awakened-poe-trade)$
        windowrule = float, tag:apt
        windowrule = noblur, tag:apt
        windowrule = noborder, tag:apt
        windowrule = noshadow, tag:apt

        # Rules for anki
        windowrule = float, class:^(anki)$

        windowrule = tag +gw2, class:^(steam_app_1284210)$
        windowrule = noblur, tag:gw2
        windowrule = noborder, tag:gw2

        # Rules for godot
        windowrule = tag +godot, class:^(Godot)$, title:^(.+)$
        windowrule = center, tag:godot
        windowrule = size 50% 50%, tag:godot
      '';
  };
}
