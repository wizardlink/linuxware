{ pkgs, ... }:

{
  services.jellyfin = {
    enable = true;
    openFirewall = true;
    user = "wizardlink";
    package = pkgs.jellyfin.override {
      jellyfin-web = pkgs.jellyfin-web.overrideAttrs (
        final: prev: {
          installPhase = ''
            runHook preInstall

            # Inject the skip intro button script.
            sed -i "s#</head>#<script src=\"configurationpage?name=skip-intro-button.js\"></script></head>#" dist/index.html

            mkdir -p $out/share
            cp -a dist $out/share/jellyfin-web

            runHook postInstall
          '';
        }
      );
    };
  };

  services.jellyseerr = {
    enable = true;
    openFirewall = true;
    package = pkgs.jellyseerr.overrideAttrs (
      _final: _prev: {
        dontCheckForBrokenSymlinks = true;
      }
    );
  };
}
