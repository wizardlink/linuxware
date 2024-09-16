{ ... }:

{
  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable nh, a bundle of CLI utilities for NixOS
  programs.nh = {
    enable = true;

    # Enable automatic garbage collection.
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";

    flake = "/home/wizardlink/.system";
  };

  # Optimize storage
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  # Enable Hyprland's cachix
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];
}
