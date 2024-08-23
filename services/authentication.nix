{ pkgs, ... }:

{
  # Enable polkit,
  security.polkit.enable = true;

  # Install an agent to interface with it.
  environment.systemPackages = with pkgs; [ polkit_gnome ];

  # And enable GNOME keyring for registering keys.
  services.gnome.gnome-keyring.enable = true;
}
