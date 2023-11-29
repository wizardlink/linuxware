{ pkgs, ... }:

{
  programs.wezterm = {
    enable = true;
    extraConfig = builtins.readFile ./wezterm.lua;
    package = (pkgs.callPackage ./package.nix {});
  };
}
