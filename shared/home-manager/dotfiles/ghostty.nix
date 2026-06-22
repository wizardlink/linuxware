{ ... }:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    systemd.enable = true;

    settings = {
      font-size = 12;
      font-family = "BlexMono Nerd Font";

      theme = "Catppuccin Frappe";

      background-opacity = 0.8;

      window-padding-x = 18;
      window-padding-y = 18;

      # Do not show the popup with the new size of a window
      resize-overlay = "never";
    };
  };
}
