{ ... }:

{
  services._3proxy = {
    enable = true;

    services = [
      {
        type = "proxy";
        auth = [ "strong" ];
        acl = [
          {
            rule = "allow";
            users = [ "stella" ];
          }
        ];
      }
    ];
    usersFile = "/var/lib/3proxy/3proxy.passwd";
  };

  # Open HTTP/HTTPS proxy port
  networking.firewall = {
    allowedTCPPorts = [
      3128
    ];
    allowedUDPPorts = [
      3128
    ];
  };
}
