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
