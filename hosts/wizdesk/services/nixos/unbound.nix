{ ... }:

{
  services.unbound = {
    enable = true;

    # Default is 53 and we want Pi-hole to bind to it.
    settings.server.port = 5335;
  };
}
