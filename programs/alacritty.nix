{ pkgs, ... }:

{
  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "FantasqueSansM Nerd Font";
          style = "Regular";
        };

        size = 13;
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
