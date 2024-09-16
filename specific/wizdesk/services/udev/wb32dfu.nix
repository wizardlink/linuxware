{
  stdenv,
}:

stdenv.mkDerivation {
  pname = "wb32dfu-udev-rules";
  version = "0-unstable-2024-09-15";
  src = ./.;

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    install -D wb32dfu.rules $out/lib/udev/rules.d/50-wb32dfu.rules

    runHook postInstall
  '';
}
