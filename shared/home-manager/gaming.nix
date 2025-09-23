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
    protontricks
    r2modman
    self.packages.${system}.deadlock-api-ingest
    wineWowPackages.stableFull
    winetricks

    # Games
    openttd
    prismlauncher
    shattered-pixel-dungeon
    xonotic
  ];
}
