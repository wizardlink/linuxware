{ nix-minecraft, pkgs, ... }:

{
  imports = [ nix-minecraft.nixosModules.minecraft-servers ];
  nixpkgs.overlays = [ nix-minecraft.overlay ];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers.cobblemon = {
      enable = true;
      package = pkgs.fabricServers.fabric-1_21_1.override { loaderVersion = "0.18.0"; };

      openFirewall = true;
      autoStart = true;

      jvmOpts = "-Xms2048M -Xmx8192M -XX:+AlwaysPreTouch -XX:+DisableExplicitGC -XX:+UseG1GC -XX:+UnlockExperimentalVMOptions -XX:MaxGCPauseMillis=50 -XX:G1HeapRegionSize=4M -XX:TargetSurvivorRatio=90 -XX:G1NewSizePercent=50 -XX:G1MaxNewSizePercent=80 -XX:InitiatingHeapOccupancyPercent=10 -XX:G1MixedGCLiveThresholdPercent=50";

      operators = {
        WizardLink = {
          uuid = "55a58451-8fe9-4dfe-8011-1509e948e7a6";
          level = 3;
        };
      };

      serverProperties = {
        allow-flight = true;
        max-players = 15;
        motd = "Welcome to \\u00A7c\\u00A7lHydractify\\u00A7r's \\u00A7bCobblemon\\u00A7r server!";
      };
    };
  };
}
