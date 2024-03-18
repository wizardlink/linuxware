{ pkgs, hyprland, ... }:

{
  imports = [ hyprland.homeManagerModules.default ];

  wayland.windowManager.hyprland = {
    enable = true;

    extraConfig = ''
      # Catppuccin Macchiato - https://github.com/catppuccin/hyprland
      $rosewaterAlpha = rgb(f4dbd6)
      $flamingoAlpha  = rgb(f0c6c6)
      $pinkAlpha      = rgb(f5bde6)
      $mauveAlpha     = rgb(c6a0f6)
      $redAlpha       = rgb(ed8796)
      $maroonAlpha    = rgb(ee99a0)
      $peachAlpha     = rgb(f5a97f)
      $yellowAlpha    = rgb(eed49f)
      $greenAlpha     = rgb(a6da95)
      $tealAlpha      = rgb(8bd5ca)
      $skyAlpha       = rgb(91d7e3)
      $sapphireAlpha  = rgb(7dc4e4)
      $blueAlpha      = rgb(8aadf4)
      $lavenderAlpha  = rgb(b7bdf8)

      $textAlpha      = rgb(cad3f5)
      $subtext1Alpha  = rgb(b8c0e0)
      $subtext0Alpha  = rgb(a5adcb)

      $overlay2Alpha  = rgb(939ab7)
      $overlay1Alpha  = rgb(8087a2)
      $overlay0Alpha  = rgb(6e738d)

      $surface2Alpha  = rgb(5b6078)
      $surface1Alpha  = rgb(494d64)
      $surface0Alpha  = rgb(363a4f)

      $baseAlpha      = rgb(24273a)
      $mantleAlpha    = rgb(1e2030)
      $crustAlpha     = rgb(181926)

      $rosewater = 0xfff5e0dc
      $flamingo  = 0xfff2cdcd
      $pink      = 0xfff5c2e7
      $mauve     = 0xffcba6f7
      $red       = 0xfff38ba8
      $maroon    = 0xffeba0ac
      $peach     = 0xfffab387
      $yellow    = 0xfff9e2af
      $green     = 0xffa6e3a1
      $teal      = 0xff94e2d5
      $sky       = 0xff89dceb
      $sapphire  = 0xff74c7ec
      $blue      = 0xff89b4fa
      $lavender  = 0xffb4befe

      $text      = 0xffcdd6f4
      $subtext1  = 0xffbac2de
      $subtext0  = 0xffa6adc8

      $overlay2  = 0xff9399b2
      $overlay1  = 0xff7f849c
      $overlay0  = 0xff6c7086

      $surface2  = 0xff585b70
      $surface1  = 0xff45475a
      $surface0  = 0xff313244

      $base      = 0xff1e1e2e
      $mantle    = 0xff181825
      $crust     = 0xff11111b

      #
      # Please note not all available settings / options are set here.
      # For a full list, see the wiki
      #

      autogenerated = 0 # remove this line to remove the warning

      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = DP-3, 1920x1080@75, 2560x0, 1
      monitor = DP-2, 2560x1440@165, 0x0, 1

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more

      # Execute your favorite apps at launch
      exec-once = ~/.local/share/scripts/hyprland/start_services.sh

      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      # Some default env vars.
      env = XCURSOR_SIZE,36
      env = QT_QPA_PLATFORM,wayland

      # For all categories, see https://wiki.hyprland.org/Configuring/Variables/
      input {
          kb_layout = us,br
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
          # FIXME: Check these deprecations.
          #blur = yes
          #blur_size = 3
          #blur_passes = 1
          #blur_new_optimizations = on

          drop_shadow = yes
          shadow_range = 4
          shadow_render_power = 3
          col.shadow = $crust
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
          new_is_master = true
      }

      gestures {
          # See https://wiki.hyprland.org/Configuring/Variables/ for more
          workspace_swipe = off
      }

      # Example windowrule v1
      # windowrule = float, ^(kitty)$
      # Example windowrule v2
      # windowrulev2 = float,class:^(kitty)$,title:^(kitty)$
      # See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

      # Bind workspaces to specific monitors
      workspace = 1, monitor:DP-2
      workspace = 2, monitor:DP-3
      workspace = 3, monitor:DP-2
      workspace = 4, monitor:DP-3
      workspace = 5, monitor:DP-2
      workspace = 6, monitor:DP-3
      workspace = 7, monitor:DP-2
      workspace = 8, monitor:DP-3
      workspace = 9, monitor:DP-2
      workspace = 0, monitor:DP-3

      # See https://wiki.hyprland.org/Configuring/Keywords/ for more
      $mainMod = SUPER

      # Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
      bind = $mainMod CTRL, F, fakefullscreen
      bind = $mainMod CTRL, K, exec, hyprctl switchxkblayout www.hfd.cn-monsgeek-keyboard-1 next
      bind = $mainMod CTRL, L, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy
      bind = $mainMod CTRL, P, exec, ~/.local/share/scripts/hyprland/screenshot_area.sh
      bind = $mainMod CTRL, V, pin
      bind = $mainMod SHIFT, F, fullscreen, 1
      bind = $mainMod SHIFT, P, exec, ~/.local/share/scripts/hyprland/screenshot.sh
      bind = $mainMod, C, killactive
      bind = $mainMod, E, exec, wezterm start fish -c "ya"
      bind = $mainMod, F, fullscreen
      bind = $mainMod, M, exit
      bind = $mainMod, O, togglesplit # dwindle
      bind = $mainMod, P, pseudo # dwindle
      bind = $mainMod, Q, exec, wezterm
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
      bindm = $mainMod, mouse:272, movewindow
      bindm = $mainMod, mouse:273, resizewindow

      # Window rules
      windowrulev2 = float,class:(steam) # Make sure all Steam windows float
      windowrulev2 = opacity 0.0 override 0.0 override,class:^(xwaylandvideobridge)$
      windowrulev2 = noanim,class:^(xwaylandvideobridge)$
      windowrulev2 = nofocus,class:^(xwaylandvideobridge)$
      windowrulev2 = noinitialfocus,class:^(xwaylandvideobridge)$

      # Rules for windowkill
      windowrule = noborder, ^(steam_app_2726450)$
      windowrule = pin, ^(steam_app_2726450)$
      windowrule = opacity 0.9, ^(steam_app_2726450)$
    '';
  };
}
