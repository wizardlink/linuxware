{ self, pkgs, ... }:

{
  home.file = {
    # Configuration for gamemode, for running games with optimizations.
    ".config/gamemode.ini".source = ./dotfiles/gamemode.ini;

    # Configure DXVK
    ".config/dxvk.conf".text = ''
      dxvk.enableGraphicsPipelineLibrary = Auto
    '';

    ".local/share/scripts/rpc-bridge" = {
      source = pkgs.fetchzip {
        url = "https://github.com/EnderIce2/rpc-bridge/releases/download/v1.4.0.1/bridge.zip";
        hash = "sha256-bfGduu8DbhrPJXihTLlaKTiuBsDB6QRjQtF8zba/hO4=";
        stripRoot = false;
      };
      recursive = true;
    };
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
