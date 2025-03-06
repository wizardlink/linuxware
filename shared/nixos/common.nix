{ pkgs, nixpkgs, ... }:

{
  # Enable experimental features
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Optimize storage
  nix.optimise.automatic = true;
  nix.settings.auto-optimise-store = true;

  # Pin the nix registry
  nix.registry = {
    nixpkgs.flake = nixpkgs;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable nh, a bundle of CLI utilities for NixOS
  programs.nh = {
    enable = true;

    # Enable automatic garbage collection.
    clean.enable = true;
    clean.dates = "daily";
    clean.extraArgs = "--keep-since 4d --keep 3";

    flake = "/home/wizardlink/.system";
  };

  # Enable flatpak to all users.
  services.flatpak.enable = true;

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

    # Networking
    gping
    nmap

    # Processes
    (btop.override {
      # AMD GPU support
      rocmSupport = true;
    })
    killall

    # Filter
    fzf
    ripgrep
  ];
}
