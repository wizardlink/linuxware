{
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    openttd
  ];

  systemd.user.services.openttd = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "OpenTTD Tmux server";

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux -L openttd new -s OpenTTD -d '${pkgs.openttd}/bin/openttd -g /home/wizardlink/.local/share/openttd/save/hyfy.sav -D'";
      ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t OpenTTD";
      Restart = "on-failure";
      Type = "forking";
    };
  };

  systemd.user.services.openttd-rcon = {
    Install.WantedBy = [ "default.target" ];

    Unit = {
      Description = "OpenTTD RCON Password set";
      After = [ "openttd.service" ];
    };

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux -L openttd send-keys -t OpenTTD 'rcon_pw aaaa' Enter";
      Type = "oneshot";
    };
  };

  systemd.user.services.openttd-save = {
    Install.WantedBy = [ "default.target" ];

    Unit = {
      Description = "OpenTTD RCON Password set";
      After = [ "openttd.service" ];
    };

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux -L openttd send-keys -t OpenTTD 'save hyfy' Enter";
      Type = "simple";
      Restart = "always";
      RestartSec = "1800s";
    };
  };
}
