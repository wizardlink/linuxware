{ ... }:

{
  services.nix-serve = {
    enable = true;
    port = 7373;
    secretKeyFile = "/etc/keys/nixbin.thewizard.link-1";
  };
}
