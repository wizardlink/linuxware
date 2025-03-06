{ pkgs, hyprland, ... }:

let
  hyprland-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  # Enable Hyprland's cachix
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

  # Enable Hyprland
  programs.hyprland = {
    enable = true;

    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Overwrite the Mesa packages with Hyprland's for consitency
  hardware.graphics = {
    package = hyprland-pkgs.mesa.drivers;
    package32 = hyprland-pkgs.pkgsi686Linux.mesa.drivers;
  };
}
