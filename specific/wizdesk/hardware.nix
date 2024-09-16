{ pkgs, ... }:

{
  # Enable Zenergy
  boot.extraModulePackages = [
    (pkgs.callPackage ../kernel/zenergy.nix { kernel = pkgs.linux_zen; })
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
