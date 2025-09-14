{ pkgs, ... }:

{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;

    font = "IBM Plex Sans";

    extraConfig = {
      disable-history = false;
      display-Network = " 󰤨  Network";
      display-drun = "   Apps ";
      display-run = "   Run ";
      display-window = " 﩯  Window";
      drun-display-format = "{icon} {name}";
      hide-scrollbar = true;
      icon-theme = "Papirus-Dark";
      location = 0;
      modi = "run,drun,window";
      show-icons = true;
      sidebar-mode = true;
      terminal = "alacritty";
    };

    theme = ./catppuccin-frappe.rasi;
  };
}
