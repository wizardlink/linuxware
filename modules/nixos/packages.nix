{ pkgs, ... }:

{
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
    settings = {
      gpu = {
        apply_gpu_optimisations = "accept-responsibility";
        gpu_device = 1;
        amd_performance_level = "auto";
      };
    };
  };

  # Enable KDEConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

  # Enable Docker.
  virtualisation.docker.enable = true;

  # Enable virt-manager
  programs.virt-manager.enable = true;

  # Enable virtd and spice USB redirection
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## Tools
    # Utilities
    bat
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
        font = "IBM Plex Sans";
        fontSize = "11";
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
  ];
}
