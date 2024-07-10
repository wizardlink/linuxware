{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "wizardlink";

    cacheDir = "/mnt/media/jellyfin/cache";
  };
}
