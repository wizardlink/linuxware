{ pkgs, ... }:

{
  services.postgresql = {
    enable = true;

    initialScript = pkgs.writeText "backend-initScript" ''
      CREATE ROLE wizardlink WITH LOGIN SUPERUSER PASSWORD 'wizardlink' CREATEDB CREATEROLE REPLICATION;
      CREATE DATABASE wizardlink;
      GRANT ALL PRIVILEGES ON DATABASE wizardlink TO wizardlink;
    '';
  };
}
