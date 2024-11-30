{
  pkgs,
  lib,
  config,
  ...
}:

{
  # Enable polkit,
  security.polkit.enable = true;

  # install an agent to interface with it,
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  # And enable GNOME keyring for registering keys.
  services.gnome.gnome-keyring.enable = true;

  # Enable flatpak to all users.
  services.flatpak.enable = true;

  services.postgresql = {
    identMap = lib.mkIf config.services.postgresql.enable ''
      # MAP_NAME        SYSTEM_USER     DB_USER
        superuser_map   root            postgres
        superuser_map   postgres        postgres
        superuser_map   /^(.*)$         \1
    '';

    authentication = lib.mkIf config.services.postgresql.enable (
      lib.mkOverride 10 ''
        # TYPE    DATABASE      USER  ADDRESS         METHOD    MAP
          local   all           all                   peer      map=superuser_map
          host    all           all   127.0.0.1/32    md5
          host    all           all   ::1/128         md5
          local   replication   all                   peer      map=superuser_map
          host    replication   all   127.0.0.1/32    ident     map=superuser_map
          host    replication   all   ::1/128         ident     map=superuser_map
      ''
    );
  };
}
