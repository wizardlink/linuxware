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
      header X-Robots-Tag "none"
      reverse_proxy 127.0.0.1:8096 {
        flush_interval -1
      }
    '';

    virtualHosts."jellyseerr.thewizard.link".extraConfig = ''
      header X-Robots-Tag "none"
      reverse_proxy http://127.0.0.1:5055
    '';

    virtualHosts."foundry.thewizard.link".extraConfig = ''
      header X-Robots-Tag "none"
      reverse_proxy 127.0.0.1:30000 {
          flush_interval -1
        }
    '';

    virtualHosts."git.thewizard.link".extraConfig = ''
      reverse_proxy 127.0.0.1:3788
    '';

    virtualHosts."files.thewizard.link".extraConfig = ''
      root * /srv/files
      header X-Robots-Tag "none"
      file_server
    '';

    virtualHosts."torrent.thewizard.link".extraConfig = ''
      header X-Robots-Tag "none"
      reverse_proxy 127.0.0.1:8144
    '';

    virtualHosts."shoko.thewizard.link".extraConfig = ''
      header X-Robots-Tag "none"
      reverse_proxy 127.0.0.1:8111
    '';

    virtualHosts."nixbin.thewizard.link".extraConfig = ''
      header X-Robots-Tag "none"
      reverse_proxy 127.0.0.1:7373
    '';
  };
}
