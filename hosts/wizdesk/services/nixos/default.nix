{ ... }:

{
  imports = [
    ./3proxy.nix
    ./archi.nix
    ./caddy.nix
    ./forgejo.nix
    ./jellyfin.nix
    ./nix-serve.nix
    ./postgresql.nix
    ./sunshine.nix
  ];
}
