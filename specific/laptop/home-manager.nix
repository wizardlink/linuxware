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

  # Add monitor configuration to hyprland
  modules.hyprland.extraConfig = # hyprlang
    ''
      # See https://wiki.hyprland.org/Configuring/Monitors/
      monitor = DP-3, 1920x1080@74.973, 2561x0, 1
      monitor = DP-2, 2560x1440@165.00301, 0x0, 1
    '';
}
