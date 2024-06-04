{ ... }:

{
  services.archisteamfarm = {
    enable = true;
    web-ui.enable = true;

    bots.wizardlink = {
      enabled = true;
      passwordFile = /var/lib/archisteamfarm/bots/wizardlink.password;
      username = "master1891891";

      settings = {
        CustomGamePlayedWhileFarming = "In the fields";
      };
    };

    bots.zak = {
      enabled = true;
      passwordFile = /var/lib/archisteamfarm/bots/zak.password;
      username = "matheuszak";
    };
  };
}