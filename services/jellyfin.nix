{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "wizardlink";

    package = pkgs.jellyfin.override {
      jellyfin-web = pkgs.jellyfin-web.overrideAttrs (oldAttrs: {
        patches = [
          (pkgs.fetchpatch {
            url =
              "https://github.com/jellyfin/jellyfin-web/compare/v${oldAttrs.version}...ConfusedPolarBear:jellyfin-web:intros.diff";
            hash = "sha256-qm4N4wMUFc4I53oQJUK1Six0cahVYz3J+FgO2vvSvXM=";
          })
        ];
      });
    };
  };
}
