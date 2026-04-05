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
          terminal = [ "alacritty" ];
        };
        idle = {
          lockBeforeSleep = false;
          timeouts = [ ];
        };
      };

      bar.status = {
        showBattery = false;
      };

      # "Open" notification on clicking.
      notifs.actionOnClick = true;

      services = {
        useFahrenheit = false;
        useFahrenheitPerformance = false;
        useTwelveHourClock = false;
      };
    };
  };
}
