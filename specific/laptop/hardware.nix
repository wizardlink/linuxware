{ config, ... }:

{
  # Enable Zenergy
  boot.initrd.kernelModules = [
    "zenergy"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.zenergy
  ];

  # enable a better driver for wireless xbox controllers.
  hardware.xpadneo.enable = true;
}
