{ pkgs, ... }:

let
  catppuccin-theme = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "alacritty";
    rev = "94800165c13998b600a9da9d29c330de9f28618e";
    hash = "sha256-Pi1Hicv3wPALGgqurdTzXEzJNx7vVh+8B9tlqhRpR2Y=";
  };
in
{
  programs.alacritty = {
    enable = true;
    settings = {
      general.import = [ "${catppuccin-theme}/catppuccin-frappe.toml" ];

      font = {
        normal = {
          family = "BlexMono Nerd Font";
          style = "Regular";
        };

        size = 12;
      };

      window = {
        decorations = "None";
        opacity = 0.88;
        blur = true;

        padding = {
          x = 18;
          y = 18;
        };
      };
    };
  };
}
