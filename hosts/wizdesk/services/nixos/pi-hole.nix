{ ... }:

{
  services.pihole-ftl = {
    enable = true;

    settings = {
      dns.upstreams = [
        "127.0.0.1#5335"
      ];
    };

    lists = [
      {
        url = "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
        type = "block";
        enabled = true;
        description = "Steven Black's Unified Hosts";
      }
      {
        url = "https://cdn.jsdelivr.net/gh/hagezi/dns-blocklists@latest/adblock/light.txt";
        type = "block";
        enabled = true;
        description = "Hagezi Multi Light";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "4774s" ];
  };
}
