{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "wizardlink";
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
  };
}
