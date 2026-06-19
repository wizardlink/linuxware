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

    # Enable hypridle
    services.hypridle = lib.mkIf cfg.hypridle.enable {
      enable = true;

      settings = {
        listener = [
          {
            timeout = 180;
            on-timeout = "hyprctl dispatch dpms off";
            on-resume = "hyprctl dispatch dpms on";
          }
        ];
      };
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
    xdg.configFile."hypr" = {
      source = ./config;
      recursive = true;
    };
  };
}
