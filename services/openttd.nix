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
      ExecStart = "${pkgs.tmux}/bin/tmux new -s OpenTTD -d '${pkgs.openttd}/bin/openttd -D'";
      ExecStop = "${pkgs.tmux}/bin/tmux kill-server";
      Restart = "on-failure";
      Type = "forking";
    };
  };
}
