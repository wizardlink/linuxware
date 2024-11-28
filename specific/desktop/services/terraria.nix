{
  pkgs,
  ...
}:

{
  systemd.user.services.terraria = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "Terraria Tmux Server";

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux new -s Terraria -d 'fhs -c \"dotnet ./tModLoader.dll -server -config serverconfig.txt\"'";
      ExecStop = "${pkgs.tmux}/bin/tmux kill-server";
      Restart = "on-failure";
      Type = "forking";
    };
  };
}
