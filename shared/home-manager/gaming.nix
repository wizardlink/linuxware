{ self, pkgs, ... }:

{
  home.file = {
    # Configuration for gamemode, for running games with optimizations.
    ".config/gamemode.ini".source = ./dotfiles/gamemode.ini;

    # Configure DXVK
    ".config/dxvk.conf".text = ''
      dxvk.enableGraphicsPipelineLibrary = Auto
    '';
  };

  home.packages = with pkgs; [
    gamescope
    heroic
    packwiz
    protonplus
    protontricks
    r2modman
    self.packages.${pkgs.stdenv.hostPlatform.system}.deadlock-api-ingest
    wineWow64Packages.stagingFull
    winetricks

    # Games
    openttd
    prismlauncher
    xonotic
    #self.packages.${pkgs.stdenv.hostPlatform.system}.ryubinx
  ];
}
