{ pkgs, nix-minecraft, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "https://git.thewizard.link/wizardlink/silly-pack/raw/tag/1.0.8/pack.toml";
    packHash = "sha256-sCk9OO1q+/c1A6ns4zhvneulNtmEMr1yz4+Ku+A+mdk=";
  };
in
{
  imports = [ nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ nix-minecraft.overlay ];

  # Needed to package modpacks.
  environment.systemPackages = [ pkgs.packwiz ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      silly-pack = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_20_1.override { loaderVersion = "0.15.11"; };
        autoStart = true;

        jvmOpts = "-Xms512M -Xmx4096M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=4M -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=50";

        serverProperties = {
          allow-flight = true;
          difficulty = "normal";
          enforce-secure-profile = true;
          level-name = "horror";
          motd = "\\u00A70Ready to run?\\u00A7r";
          pvp = true;
          resource-pack = "https://cdn.modrinth.com/data/p1WH6sHr/versions/3lQn31SZ/From-The-Fog-1.20.5-1.20.6-v1.9.3-Data-Resource-Pack.zip";
          server-ip = "192.168.0.100";
          server-port = 25565;
          view-distance = 16;
        };

        symlinks = {
          mods = "${modpack}/mods";
          "ops.json" = ./ops.json;
        };
      };
    };
  };
}
