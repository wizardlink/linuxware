{ pkgs, nix-minecraft, ... }:

let
  modpack = pkgs.fetchPackwizModpack {
    url = "http://files.thewizard.link/horror/pack.toml";
    packHash = "sha256-Huqdl1nGMJC/hvkK8HKxOMHectFioY7zaNeT+D6Ur/8=";
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
      horror = {
        enable = true;
        package = pkgs.fabricServers.fabric-1_20_6;
        autoStart = true;

        jvmOpts = "-Xms512M -Xmx8192M";

        serverProperties = {
          allow-flight = true;
          difficulty = "normal";
          enforce-secure-profile = true;
          level-name = "horror";
          motd = "\\u00A70Are you a hero?\\u00A7r";
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
