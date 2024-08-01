{ ... }:
{
  services.caddy = {
    enable = true;
    email = "contact@thewizard.link";

    virtualHosts."thewizard.link".extraConfig = ''
      redir https://github.com/wizardlink/
      header Strict-Transport-Security "max-age=63072000; includeSubDomains"
    '';

    virtualHosts."jellyfin.thewizard.link".extraConfig = ''
      encode gzip
      reverse_proxy 127.0.0.1:8096 {
        flush_interval -1
      }
    '';

    virtualHosts."foundry.thewizard.link".extraConfig = ''
      reverse_proxy 127.0.0.1:30000 {
          flush_interval -1
        }
    '';
  };
}
