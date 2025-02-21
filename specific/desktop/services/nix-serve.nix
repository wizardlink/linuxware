{ ... }:

{
  services.nix-serve = {
    enable = true;
    port = 7373;
    secretKeyFile = "/etc/keys/nix-store-wizdesk-1";
  };
}
