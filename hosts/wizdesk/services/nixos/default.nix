{ ... }:

{
  imports = [
    ./archi.nix
    ./caddy.nix
    ./forgejo.nix
    ./jellyfin.nix
    ./minecraft.nix
    ./nix-serve.nix
    ./postgresql.nix
  ];
}
