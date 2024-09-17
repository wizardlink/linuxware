{ ... }:

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

  # Add monitor configuration to hyprland
  modules.hyprland.extraConfig = # hyprlang
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
}
