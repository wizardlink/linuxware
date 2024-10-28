{ pkgs, config, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Add AMD drivers.
  boot.initrd.kernelModules = [
    "amdgpu"
    "v4l2loopback"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
  ];

  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="Virtual camera" exclusive_caps=1
  '';

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
      StreamLocalBindUnlink = "yes";
    };
  };
}
