{ ... }:

{
  imports = [
    ./archi.nix
    ./caddy.nix
    ./forgejo.nix
    ./jellyfin.nix
    ./nix-serve.nix
    ./postgresql.nix
  ];
}
