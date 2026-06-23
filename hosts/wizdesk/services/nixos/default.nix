{ ... }:

{
  imports = [
    ./3proxy.nix
    ./archi.nix
    ./caddy.nix
    ./forgejo.nix
    ./jellyfin.nix
    ./nix-serve.nix
    ./pi-hole.nix
    ./postgresql.nix
    ./sunshine.nix
    ./unbound.nix
  ];
}
