{ pkgs, ... }:

{
  systemd.user.services.terraria = {
    Install.WantedBy = [ "default.target" ];

    Unit.Description = "Terraria TMUX Server";

    Service = {
      ExecStart = "${pkgs.tmux}/bin/tmux -S /run/user/1000/tmux-1000/terraria new -s Terraria -d /etc/profiles/per-user/wizardlink/bin/fhs -c 'dotnet ./tModLoader.dll -server -config serverconfig.txt'";
      ExecStop = "${pkgs.tmux}/bin/tmux kill-session -t Terraria";
      Restart = "on-failure";
      Type = "forking";
      WorkingDirectory = "/mnt/ssd/SteamLibrary/steamapps/common/tModLoader";
    };
  };
}
