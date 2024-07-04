{ ... }:

{
  services.archisteamfarm = {
    enable = true;
    web-ui.enable = true;

    bots.wizardlink = {
      enabled = true;
      passwordFile = /home/wizardlink/.local/share/archisteamfarm/bots/wizardlink.password;
      username = "master1891891";

      settings = {
        CustomGamePlayedWhileFarming = "In the fields";
      };
    };

    bots.zak = {
      enabled = true;
      passwordFile = /home/wizardlink/.local/share/archisteamfarm/bots/zak.password;
      username = "matheuszak";
    };
  };
}
