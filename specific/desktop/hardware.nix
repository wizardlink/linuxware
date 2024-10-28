{ pkgs, config, ... }:

{
  # Enable Zenergy
  boot.initrd.kernelModules = [
    "zenergy"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.zenergy
  ];

  # Enable openrazer for managing Razer products' configuration
  hardware.openrazer = {
    enable = true;
    users = [ "wizardlink" ];
  };

  services.udev = {
    # Vial udev rule for Monsgeek M1
    extraRules = ''
      # Monsgeek M1
      KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0005", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
    '';

    # WB32 DFU rules - needed for flashing
    packages = [ (pkgs.callPackage ./services/udev/wb32dfu.nix { }) ];
  };

  # enable a better driver for wireless xbox controllers.
  hardware.xpadneo.enable = true;
}
