{ pkgs, ... }:

{
  #
  ## HOME CONFIGURATION #
  #

  # Import configurations for better modularity.
  imports = [
    ../../modules/home-manager
    ./services/openttd.nix
    ./services/terraria.nix
    ./services/hydractify-bot.nix
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

  home.sessionVariables = {
    EDITOR = "nvim";
    MANPAGER = "nvim +Man!";
  };

  home.file = {
    # Create wallpaper script to be read by the start_services.sh script.
    ".local/share/scripts/wallpaper.sh" = {
      executable = true;
      text = # sh
        ''
          #
          ## Start wallpaper daemon and set one.
          #
          OUTPUT_1="DP-2"
          IMAGE_1="/mnt/internal/personal/wallpapers/wallhaven-vqlvm8.jpg"

          OUTPUT_2="DP-3"
          IMAGE_2="/mnt/internal/personal/wallpapers/wallhaven-2yl6px.jpg"

          function load_wallpapers() {
            swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 60 -o $OUTPUT_1 $IMAGE_1;
            swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 60 -o $OUTPUT_2 $IMAGE_2
          }

          if ! swww query; then
            swww-daemon &
          fi

          load_wallpapers &
        '';
    };
  };

  #
  # PACKAGES #
  #

  programs.direnv = {
    config = {
      whitelist = {
        prefix = [
          "/mnt/internal/hydractify/GitHub"
          "/mnt/internal/personal/projects"
          "/mnt/internal/repos"
          "/mnt/internal/shared/projects"
          "/mnt/internal/shared/work"
        ];
      };
    };
  };

  home.packages = with pkgs; [
    pcsx2

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
              (base.targetPkgs pkgs)
              ++ (with pkgs; [
                nodejs
                dotnet-sdk_8
              ])
            );
          profile = "export FHS=1";
          runScript = "bash";
          extraOutputsToInstall = [ "dev" ];
        }
      )
    )
  ];

  #
  # MODULES #
  #

  modules.hyprland = {
    # Enable scripts
    scripts = {
      startup.enable = true;
      screenshot.enable = true;
    };

    # Add monitor configuration to hyprland
    extraConfig = # hyprlang
      ''
        # See https://wiki.hyprland.org/Configuring/Monitors/
        monitor = DP-3, 1920x1080@74.973, 2560x0, 1
        monitor = DP-2, 2560x1440@165.00301, 0x0, 1

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
      '';
  };
}
