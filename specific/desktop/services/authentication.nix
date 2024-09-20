{ pkgs, ... }:

{
  # Enable polkit,
  security.polkit.enable = true;

  # Install a keyring service and manager.
  environment.systemPackages = with pkgs; [
    libsForQt5.kwallet
    libsForQt5.kwalletmanager
  ];
}
