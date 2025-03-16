{ gakuen-cosplay, pkgs, ... }:

{
  systemd.user.services.gakuen-cosplay-api = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "Gakuen Cosplay API";

    Service = {
      ExecStart = "${gakuen-cosplay.packages.${pkgs.system}.backend}/bin/animegakuen-cosplay-backend";
      Restart = "on-failure";
      Type = "simple";
      WorkingDirectory = "/srv/gakuen_api";
    };
  };
}
