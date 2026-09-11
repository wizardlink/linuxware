{ lib, pkgs, ... }:

let
  defaultExports = # sh
    ''
      export ENABLE_LAYER_MESA_ANTI_LAG=1
      export MANGOHUD=1
    '';
  enableNTSync = "export PROTON_USE_NTSYNC=1";
  enableWayland = "export PROTON_ENABLE_WAYLAND=1";

  makeExports =
    withNTSync: withWayland: with lib; ''
      ${defaultExports}
      ${strings.optionalString withNTSync enableNTSync}
      ${strings.optionalString withWayland enableWayland}
    '';

  rpc-bridge = pkgs.fetchzip {
    url = "https://github.com/EnderIce2/rpc-bridge/releases/download/v1.4.1.3/bridge.zip";
    hash = "sha256-hOjZX1WfZULIjqJXb6gcDz4lQmQUhN2DAU1T/7UhUag=";
    stripRoot = false;
  };

  defaultCommand = # sh
    with pkgs; ''
      ${obs-studio-plugins.obs-vkcapture}/bin/obs-gamecapture ${gamemode}/bin/gamemoderun "$@"
    '';
in
{
  xdg.dataFile = {
    "scripts/games/launch.sh" = {
      executable = true;
      text = ''
        ${makeExports true false}
        ${defaultCommand}
      '';
    };

    "scripts/games/launch_nontsync.sh" = {
      executable = true;
      text = ''
        ${makeExports false false}
        ${defaultCommand}
      '';
    };

    "scripts/games/launch_wayland.sh" = {
      executable = true;
      text = ''
        ${makeExports true true}
        ${defaultCommand}
      '';
    };

    "scripts/games/launch_rpc.sh" = {
      executable = true;
      text = ''
        ${makeExports true false}
        ${rpc-bridge}/bridge.sh ${defaultCommand}
      '';
    };
  };
}
