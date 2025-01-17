{ pkgs, ... }:

{
  #
  ## HOME CONFIGURATION #
  #

  # Import configurations for better modularity.
  imports = [
    ../../modules/home-manager
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
          OUTPUT_1="eDP-1"
          IMAGE_1="/home/wizardlink/Pictures/wallhaven-x6p3y3.jpg"

          function load_wallpapers() {
            swww img -t any --transition-bezier 0.0,0.0,1.0,1.0 --transition-duration .8 --transition-step 255 --transition-fps 60 -o $OUTPUT_1 $IMAGE_1;
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
          "/home/wizardlink/Documents/projects"
        ];
      };
    };
  };

  home.packages = with pkgs; [
    ## Tools
    # Utilities
    brightnessctl

    # Create an FHS environment using the command `fhs`, enabling the execution of non-NixOS packages in NixOS!
    (
      let
        base = appimageTools.defaultFhsEnvArgs;
      in
      buildFHSEnv (
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

  # Enable neovim
  programs.neovim = {
    enable = true;

    # Enable ollama support
    ollama.enable = true;

    # Set the hostname for nixd in neovim
    nixd.hostname = "wizlap";
  };

  # Add monitor configuration to hyprland
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
        monitor = eDP-1, 1920x1080@60.01, 0x0, 1

        # Bind workspaces to specific monitors
        workspace = 1, monitor:eDP-1
        workspace = 2, monitor:eDP-1
        workspace = 3, monitor:eDP-1
        workspace = 4, monitor:eDP-1
        workspace = 5, monitor:eDP-1
        workspace = 6, monitor:eDP-1
        workspace = 7, monitor:eDP-1
        workspace = 8, monitor:eDP-1
        workspace = 9, monitor:eDP-1
        workspace = 0, monitor:eDP-1
      '';
  };
}
