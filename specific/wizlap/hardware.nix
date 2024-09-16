{ pkgs, ... }:

{
  # Enable Zenergy
  boot.extraModulePackages = [
    (pkgs.callPackage ../kernel/zenergy.nix { kernel = pkgs.linux_zen; })
  ];

  # enable a better driver for wireless xbox controllers.
  hardware.xpadneo.enable = true;
}
