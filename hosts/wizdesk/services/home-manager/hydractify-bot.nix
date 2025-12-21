{ hydractify-bot, pkgs, ... }:

{
  systemd.user.services.hydractify-bot = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "Hydractify bot";
    Unit.After = "postgresql.service";

    Service = {
      ExecStart = "${hydractify-bot.defaultPackage.${pkgs.stdenv.hostPlatform.system}}/bin/hydractify";
      Restart = "on-failure";
      Type = "simple";
      WorkingDirectory = "/mnt/internal/hydractify/GitHub/hydractify";
    };
  };
}
