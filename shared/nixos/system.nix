{ pkgs, config, ... }:

{
  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.initrd.kernelModules = [
    "v4l2loopback"
    "zenergy"
  ];

  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
    config.boot.kernelPackages.zenergy # Allows fetching power draw information on AMD CPUs
  ];

  # Configure v4l2loopback
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

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    audio.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;
  };

  # Enable fish system-wide to integrate with nixpkgs.
  programs.fish.enable = true;

  # Set fish as the default shell for all users.
  users.defaultUserShell = pkgs.fish;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # And the service that enables IPP Everywhere
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    nssmdns6 = true;
    openFirewall = true;
  };

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      StreamLocalBindUnlink = "yes";
    };
  };

  # Enable GPG.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Enable polkit,
  security.polkit.enable = true;

  # install an agent to interface with it,
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  # And enable GNOME keyring for registering keys.
  services.gnome.gnome-keyring.enable = true;
}
