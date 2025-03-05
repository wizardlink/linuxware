{ gakuen-cosplay, pkgs, ... }:

{
  systemd.user.services.gakuen-cosplay-api = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "Gakuen Cosplay API";

    Service = {
      ExecStart = "${gakuen-cosplay.packages.${pkgs.system}.backend}/bin/cosplayer_submission";
      Restart = "on-failure";
      Type = "simple";
      WorkingDirectory = "/mnt/internal/shared/work/gakuen/projects/cosplayer_submission/packages/backend";
    };
  };
}
