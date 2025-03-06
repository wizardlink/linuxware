{ ... }:

{
  # Add AMD drivers
  boot.initrd.kernelModules = [
    "amdgpu"
  ];

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable fstrim for better ssd lifespan
  services.fstrim.enable = true;
}
