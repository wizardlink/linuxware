{ config, ... }:

{
  imports = [
    ../../modules/hyprland/nixos.nix
    ../../shared/nixos
    ./hardware-configuration.nix
  ];

  #
  # NIXOS #
  #

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05";

  # Consume my desktop's binary cache. This is specially useful since (in theory)
  # I will always update the flake and desktop machine first, so when I pull the changes,
  # my desktop will have all the binaries my laptop needs.
  nix.settings.substituters = [ "http://192.168.0.100:7373" ];
  nix.settings.trusted-public-keys = [
    "wizdesk-1:2UvctPjiMwMs7r2r7VPvoPmh4OcUjY3JmaRDJnOTZY8="
  ];

  #
  # SYSTEM #
  #
  networking.hostName = "wizlap"; # Define your hostname.

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDEConnect
    ];
    allowedUDPPortRanges = [
      {
        from = 1714;
        to = 1764;
      } # KDEConnect
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wizardlink = {
    createHome = true;
    description = "Alexandre Cavalheiro";
    extraGroups = [
      "docker"
      "gamemode"
      "libvirtd"
      "networkmanager"
      "openrazer"
      "postgresql"
      "wheel"
    ];

    initialPassword = "wizardlink";
    isNormalUser = true;

    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDdGOyRbu6IOw9yqotxE6m7wCif7oP/2D0tlREa5Q6uo Alexandre Cavalheiro S. Tiago da Silva <contact@thewizard.link>"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIISfCUsZrnCMZapdrvkUCrdRiX+1xuZBdGrynNRzDI2v" # SpaceEEC
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPInBFp7zBLhFluoww65CZzcnMdhndTawBv8QYJ5s/Xt david.alejandro.rubio@gmail.com" # Kodehawa
    ];
  };

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_GB.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "ja_JP.UTF-8/UTF-8"
      "pt_BR.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "en_GB.UTF-8";
    };
  };

  #
  # HARDWARE #
  #

  # enable a better driver for wireless xbox controllers.
  hardware.xpadneo.enable = true;
}
