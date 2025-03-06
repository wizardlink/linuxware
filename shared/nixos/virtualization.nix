{ pkgs, ... }:

{
  # Enable Docker.
  virtualisation.docker.enable = true;

  # Enable virt-manager
  programs.virt-manager.enable = true;

  # Enable virtd and spice USB redirection
  virtualisation.spiceUSBRedirection.enable = true;
  virtualisation.libvirtd.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
    quickemu
  ];
}
