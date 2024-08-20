{
  services.forgejo = {
    enable = true;

    lfs.enable = true;

    settings = {
      server = {
        DISABLE_REGISTRATION = true;
        HTTP_PORT = 3788;
        ROOT_URL = "https://git.thewizard.link";
      };
    };
  };
}
