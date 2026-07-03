{ pkgs, ... }:

{
  systemd.user.services.unturned = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "Unturned Tmux server";

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux -L unturned new -s Unturned -d 'fhs -c ./ServerHelper.sh +InternetServer/Default'";
      ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t Unturned";
      Restart = "always";
      Type = "forking";
      WorkingDirectory = "/home/wizardlink/.local/share/Steam/steamapps/common/U3DS";
    };
  };

  systemd.user.services.unturned-save = {
    Install.WantedBy = [ "default.target" ];

    Unit = {
      Description = "Unturned Auto Save";
      After = [ "unturned.service" ];
    };

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux -L unturned send-keys -t Unturned 'Save' Enter";
      Type = "simple";
      Restart = "always";
      RestartSec = "1800s";
    };
  };
}
