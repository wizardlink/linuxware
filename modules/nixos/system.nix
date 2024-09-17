{ pkgs, config, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Add AMD drivers.
  boot.initrd.kernelModules = [ "amdgpu" ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    efi.canTouchEfiVariables = true;
  };

  # Enables zram.
  zramSwap.enable = true;

  # Enable networking
  networking.networkmanager.enable = true;

  # Define variables that will be initialized in PAM.
  environment.sessionVariables = {
    # Set env for Fcitx5
    QMODIFIERS = "@im=fcitx5";
  };

  # Set fish as the default shell for all users.
  users.defaultUserShell = pkgs.fish;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
