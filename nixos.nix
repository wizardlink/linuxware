# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  ##
  ## NIXOS ##
  ##

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable nh, a bundle of CLI utilities for NixOS
  programs.nh = {
    enable = true;

    # Garbage collection
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";

    flake = "/home/yozawa/.system";
  };

  # Optimize storage
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  ##
  ## SYSTEM ##
  ##

  # Kernel

  # Add AMD drivers.
  boot.initrd.kernelModules = [
    "amdgpu"
    "kvm-intel"
  ];

  boot.kernelPackages = pkgs.linuxPackages_zen;

  boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [ ];

    allowedUDPPorts = [ ];

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
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Define system-wide variables.
  environment.variables = { };

  # Set fish as the default shell for all users.
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.yozawa = {
    createHome = true;
    description = "yozawa";

    group = "yozawa";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];

    initialPassword = "yozawa";
    isNormalUser = true;

    openssh.authorizedKeys.keys = [ ];
  };
  users.groups.yozawa = { };

  # Set your time zone.
  time.timeZone = "Australia/Melbourne";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    supportedLocales = [
      "C.UTF-8/UTF-8"
      "en_US.UTF-8/UTF-8"
      "en_AU.UTF-8/UTF-8"
    ];

    extraLocaleSettings = {
      LANGUAGE = "en_US.UTF-8";
      LC_ADDRESS = "en_US.UTF-8";
      LC_ALL = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_AU.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_AU.UTF-8";
      LC_PAPER = "en_AU.UTF-8";
      LC_TELEPHONE = "en_AU.UTF-8";
      LC_TIME = "en_AU.UTF-8";
    };
  };

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

  ##
  ## HARDWARE ##
  ##
  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  # Enable QMK support.
  hardware.keyboard.qmk.enable = true;

  # Enable the udev rules Steam recommends for controllers.
  hardware.steam-hardware.enable = true;

  # Enable fstrim for better ssd lifespan
  services.fstrim.enable = true;

  ##
  ## DESKTOP ##
  ##

  nixpkgs.config.allowAliases = false;

  # Enable GNOME.
  services.xserver = {
    enable = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  # Enable Dconf
  programs.dconf.enable = true;

  # Enable XDG Desktop Portals.
  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "gtk" ];
      };
    };
  };

  # Needed for home-manager
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  # Enable OpenGL.
  hardware.opengl = {
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [ rocmPackages.clr.icd ];
  };

  ##
  ## INPUT ##
  ##

  # Configure keymap in X11
  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  ##
  ## SOUND #
  ##

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    audio.enable = true;

    alsa.enable = true;
    alsa.support32Bit = true;

    pulse.enable = true;

    #jack.enable = true;
  };

  ##
  ## PACKAGES ##
  ##

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable GPG.
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  #Enable Onedrive
  services.onedrive.enable = true;

  # Allow spice usb
  virtualisation.spiceUSBRedirection.enable = true;
  services.spice-vdagentd.enable = true;

  # Enable fish system-wide to integrate with nixpkgs.
  programs.fish.enable = true;

  # Enable Steam.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;

    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  # Enable and configure gamemode.
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  # Enable KDEConnect
  programs.kdeconnect.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## Tools
    # Utilities
    bat
    btop
    duf
    fzf
    killall
    lm_sensors
    ripgrep
    tree
    unrar
    unzip
    wget
    wl-clipboard
    xclip
    zip
    zoxide

    ## Libraries
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2

    ## Hardware specific
    via
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  ##
  ## SERVICES #
  ##

  # Enable flatpak
  services.flatpak.enable = true;

  # Adds specific udev rules.
  services.udev.packages = with pkgs; [
    pkgs.via
    gnome.gnome-settings-daemon
  ];

  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [
      libpinyin
      anthy
    ];
  };

}
