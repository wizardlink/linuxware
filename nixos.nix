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
    # Include service configuration
    ./services/caddy.nix
    ./services/jellyfin.nix
  ];

  # Enable experimental features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Enable automatic garbage collection.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 1w";
  };

  # Optimize storage
  nix.settings.auto-optimise-store = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

  ##
  ## SYSTEM ##
  ##

  # Kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # Add AMD drivers.
  boot.initrd.kernelModules = [ "amdgpu" ];

  # TODO: FIX IT BEING BEING OVERWRITTEN
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
    (pkgs.callPackage ./kernel/zenergy.nix { kernel = pkgs.linux_latest; })
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      11753 # OpenRCT2
      443 # SSL
      80 # HTTP
    ];

    allowedUDPPorts = [
      11753 # OpenRCT2
      2626 # Dolphin emulator
      27015 # Source games
      8211 # Palworld
    ];

    allowedTCPPortRanges = [{
      from = 1714;
      to = 1764;
    } # KDEConnect
      ];
    allowedUDPPortRanges = [{
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
  users.users.wizardlink = {
    createHome = true;
    description = "Alexandre Cavalheiro";
    extraGroups = [ "networkmanager" "wheel" "postgresql" "docker" ];

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

    inputMethod = {
      enabled = "fcitx5";
      fcitx5.addons = [ pkgs.fcitx5-mozc pkgs.fcitx5-gtk ];
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

  # Enable openrazer for managing Razer products' configuration
  hardware.openrazer = {
    enable = true;
    users = [ "wizardlink" ];
  };

  # Enable xpadneo support.
  hardware.xpadneo.enable = true;

  # Enable fstrim for better ssd lifespan
  services.fstrim.enable = true;

  ##
  ## DESKTOP ##
  ##
  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable GDM.
  services.xserver.displayManager.sddm = {
    enable = true;
    theme = "${import ./theming/sddm.nix { inherit pkgs; }}";
  };

  # Enable OpenGL.
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;

    extraPackages = with pkgs; [
      rocm-opencl-icd # OpenGL hwa
      rocm-opencl-runtime
    ];
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
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
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

  # Enable fish system-wide to integrate with nixpkgs.
  programs.fish.enable = true;

  # Enable Steam.
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
  };

  # Enable and configure gamemode.
  programs.gamemode = {
    enable = true;
    enableRenice = true;
  };

  # Enable KDEConnect
  programs.kdeconnect.enable = true;

  # Enable Docker.
  virtualisation.docker.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## Tools
    # Utilities
    bat
    btop
    docker-compose
    duf
    fzf
    gping
    killall
    lm_sensors
    nmap
    ripgrep
    tree
    unrar
    unzip
    wget
    wl-clipboard
    xclip
    zip
    zoxide

    # File managing
    yazi

    ## Libraries
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    pkgsi686Linux.gperftools # Needed for TF2 rn :(

    ## Hardware specific
    openrazer-daemon # Razor products back-end
    polychromatic # and it's Front-end
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

  services.udev.extraRules = ''
    # Monsgeek M1
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="fffe", ATTRS{idProduct}=="0005", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  # Enable flatpak
  services.flatpak.enable = true;

  # Enable and configure PostgreSQL.
  services.postgresql = {
    enable = true;

    identMap = ''
      # MAP_NAME        SYSTEM_USER     DB_USER
        superuser_map   root            postgres
        superuser_map   postgres        postgres
        superuser_map   /^(.*)$         \1
    '';

    authentication = pkgs.lib.mkOverride 10 ''
      # TYPE    DATABASE      USER  ADDRESS         METHOD    MAP
        local   all           all                   peer      map=superuser_map
        host    all           all   127.0.0.1/32    md5
        host    all           all   ::1/128         md5
        local   replication   all                   peer      map=superuser_map
        host    replication   all   127.0.0.1/32    ident     map=superuser_map
        host    replication   all   ::1/128         ident     map=superuser_map
    '';

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE wizardlink WITH LOGIN SUPERUSER PASSWORD 'wizardlink' CREATEDB CREATEROLE REPLICATION;
      CREATE DATABASE wizardlink;
      GRANT ALL PRIVILEGES ON DATABASE wizardlink TO wizardlink;
    '';
  };
}
