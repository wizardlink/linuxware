{ pkgs, ... }:

{
  imports = [
    ./services/archi.nix
    ./services/caddy.nix
    ./services/forgejo.nix
    ./services/jellyfin.nix
  ];

  services.postgresql = {
    enable = true;

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE wizardlink WITH LOGIN SUPERUSER PASSWORD 'wizardlink' CREATEDB CREATEROLE REPLICATION;
      CREATE DATABASE wizardlink;
      GRANT ALL PRIVILEGES ON DATABASE wizardlink TO wizardlink;
    '';
  };
}
