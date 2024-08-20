{
  services.forgejo = {
    enable = true;

    lfs.enable = true;

    settings = {
      server = {
        HTTP_PORT = 3788;
        ROOT_URL = "https://git.thewizard.link";
      };

      service = {
        DISABLE_REGISTRATION = true;
        ENABLE_REVERSE_PROXY_AUTHENTICATION = true;
        ENABLE_REVERSE_PROXY_AUTHENTICATION_API = true;
      };
    };
  };
}
