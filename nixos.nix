# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  hyprland,
  ...
}:

let
  hyprland-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  ##
  ## NIXOS ##
  ##

  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    # Include service configuration
    ./services/archi.nix
    ./services/authentication.nix
    ./services/caddy.nix
    ./services/forgejo.nix
    ./services/jellyfin.nix
    ./services/minecraft
  ];

  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Enable nh, a bundle of CLI utilities for NixOS
  programs.nh = {
    enable = true;

    # Enable automatic garbage collection.
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";

    flake = "/home/wizardlink/.system";
  };

  # Optimize storage
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  # Enable Hyprland's cachix
  nix.settings.substituters = [ "https://hyprland.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
  ];

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
  boot.kernelPackages = pkgs.linuxPackages_zen;

  # Add AMD drivers.
  boot.initrd.kernelModules = [ "amdgpu" ];

  # TODO: FIX IT BEING BEING OVERWRITTEN
  boot.extraModulePackages = [
    config.boot.kernelPackages.v4l2loopback
    (pkgs.callPackage ./kernel/zenergy.nix { kernel = pkgs.linux_zen; })
  ];

  # Bootloader.
  boot.loader = {
    systemd-boot = {
      enable = true;
      configurationLimit = 10;
    };

    efi.canTouchEfiVariables = true;
  };

  # Configure options for mounted volumes.
  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/mnt/extra".options = [ "nofail" ];
    "/mnt/internal".options = [ "nofail" ];
    "/mnt/media".options = [ "nofail" ];
    "/mnt/ssd".options = [ "nofail" ];
  };

  # Enable btrf's auto scrubbing of volumes.
  services.btrfs.autoScrub = {
    enable = true;
    interval = "weekly";
    fileSystems = [ "/" ];
  };

  # Enables zram.
  zramSwap.enable = true;

  networking.hostName = "wizdesk"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable WOL on my ethernet interface.
  networking.interfaces.enp5s0.wakeOnLan.enable = true;

  # Open ports in the firewall.
  networking.firewall = {
    allowedTCPPorts = [
      443 # SSL
      6567 # Mindustry
      80 # HTTP
    ];

    allowedUDPPorts = [
      24454 # Minecraft Simple Voice Chat
      2626 # Dolphin emulator
      27015 # Source games
      28910 # Heretic II
      6567 # Mindustry
      8211 # Palworld
    ];

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

  # Define variables that will be initialized in PAM.
  environment.sessionVariables = {
    # Set env for Fcitx5
    QMODIFIERS = "@im=fcitx5";
  };

  # Set fish as the default shell for all users.
  users.defaultUserShell = pkgs.fish;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.wizardlink = {
    createHome = true;
    description = "Alexandre Cavalheiro";
    extraGroups = [
      "docker"
      "gamemode"
      "libvirtd"
      "minecraft"
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

  # Enable QMK support.
  # hardware.keyboard.qmk.enable = true;
  # FIXME: Causing issues with xpadneo :(

  # enable a better driver for wireless xbox controllers.
  hardware.xpadneo.enable = true;

  # Enable fstrim for better ssd lifespan
  services.fstrim.enable = true;

  ##
  ## DESKTOP ##
  ##

  # Enable SDDM.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-frappe";
    package = pkgs.kdePackages.sddm;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;

    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-wlr;
  };

  # Enable XDG Desktop Portals.
  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "wlr" ];
      };
    };
  };

  # Needed for home-manager
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  # Enable OpenGL.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    package = hyprland-pkgs.mesa.drivers;
    package32 = hyprland-pkgs.pkgsi686Linux.mesa.drivers;

    extraPackages = with pkgs; [
      rocm-opencl-icd # OpenGL hwa
      rocm-opencl-runtime
    ];
  };

  # Enable Thunar and it's dependencies
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin ];
  };
  programs.xfconf.enable = true; # For configuring
  services.gvfs.enable = true; # For mounting drives, trash, etc.
  services.tumbler.enable = true; # Thumbnail support

  # Enable the Fcitx5 IME
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-catppuccin
      ];

      waylandFrontend = true;
    };
  };

  ##
  ## SOUND #
  ##

  # Enable sound with pipewire.
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

  # Enable fish system-wide to integrate with nixpkgs.
  programs.fish.enable = true;

  # Enable Steam.
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
    # ^ Enables so we can transfer games to other computers in the network.

    # Add Proton-GE to 'compatibilitytools.d'.
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
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

  # Enable virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## Tools
    # Utilities
    bat
    btrfs-progs
    duf
    fuseiso
    lm_sensors
    p7zip
    tree
    unrar
    unzip
    wget
    zip

    # File managing
    sshfs
    yazi

    # Virtualization
    docker-compose
    quickemu

    # Desktop
    wl-clipboard
    xclip
    zoxide
    (catppuccin-sddm.override # So SDDM finds the theme files.
      {
        flavor = "frappe";
        font = "FantasqueSansM Nerd Font";
        fontSize = "12";
        background = "${./theming/sddm/Background.jpg}";
        loginBackground = true;
      }
    )

    # Networking
    gping
    nmap

    # Processes
    btop
    killall

    # Filter
    fzf
    ripgrep

    ## Libraries
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
    pkgsi686Linux.gperftools # Needed for TF2 rn :(

    ## Hardware specific
    openrazer-daemon # Razor products back-end
    polychromatic # and it's front-end
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

  # Enables VIA
  # services.udev.packages = [ pkgs.via ];
  # FIXME: Causing issues with xpadneo :(

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
