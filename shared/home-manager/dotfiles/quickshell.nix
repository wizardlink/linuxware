{ caelestia-shell, ... }:

{
  imports = [
    caelestia-shell.homeManagerModules.default
  ];

  programs.caelestia = {
    enable = true;

    cli = {
      enable = true;
    };

    settings = {
      general = {
        apps = {
          terminal = [ "ghostty +new-window" ];
        };

        idle = {
          timeouts = [
            {
              timeout = 180;
              idleAction = "lock";
              inhibitWhenAudio = false;
              inhibitWhenCharging = false;
              respectInhibitors = true;
            }
            {
              timeout = 300;
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
          ];
        };
      };

      # "Open" notification on clicking.
      notifs.actionOnClick = true;

      utilities.toasts = {
        kbLayoutChanged = false;
      };

      services = {
        useFahrenheit = false;
        useFahrenheitPerformance = false;
        useTwelveHourClock = false;
      };
    };
  };
}
