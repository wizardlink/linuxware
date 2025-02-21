{ ... }:

{
  imports = [
    ./services/archi.nix
    ./services/caddy.nix
    ./services/forgejo.nix
    ./services/jellyfin.nix
    ./services/nix-serve.nix
    ./services/postgresql.nix
  ];
}
