{
  services.gitea = {
    enable = true;

    lfs.enable = true;

    settings = {
      server = {
        HTTP_PORT = 3788;
        ROOT_URL = "https://git.thewizard.link";
      };
    };
  };
}
