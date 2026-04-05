{ ... }:

{
  # Add AMD drivers
  boot.initrd.kernelModules = [
    "amdgpu"
  ];

  # Tune power management
  boot.extraModprobeConfig = ''
    options amdgpu runpm=0 aspm=0 bapm=0
  '';
  services.udev.extraRules = ''
    SUBSYSTEM=="drm", DRIVERS=="amdgpu", ATTR{device/power_dpm_force_performance_level}="high"
  '';

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable fstrim for better ssd lifespan
  services.fstrim.enable = true;
}
