{ pkgs, spicetify-nix, ... }:

let
  spicePkgs = spicetify-nix.packages.${pkgs.system}.default;
in
{
  imports = [ spicetify-nix.homeManagerModule ];

  home.packages = with pkgs; [ spotify ];

  programs.spicetify = {
    enable = false; # Currently broken, see https://github.com/the-argus/spicetify-nix/issues/62
    theme = spicePkgs.themes.catppuccin;
    colorScheme = "frappe";

    enabledExtensions = with spicePkgs.extensions; [
      autoVolume
      shuffle
    ];
  };
}
