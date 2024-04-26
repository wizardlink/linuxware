{ ... }:

{
  services.archisteamfarm = {
    enable = true;
    web-ui.enable = true;

    # bots.wizardlink = {
    #   enabled = true;
    #   passwordFile = /var/lib/asf/bot_info/wizardlink.password;
    #   username = builtins.readFile /var/lib/asf/bot_info/wizardlink.username;
    #
    #   settings = {
    #     CustomGamePlayedWhileFarming = "In the fields";
    #     CustomGamePlayedWhileIdle = "Out from the fields";
    #   };
    # };
  };
}
