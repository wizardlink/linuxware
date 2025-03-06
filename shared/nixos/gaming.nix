{ pkgs, ... }:

{
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
}
