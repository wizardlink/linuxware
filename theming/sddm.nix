{ pkgs }:

let
  imgLink = "https://w.wallhaven.cc/full/1p/wallhaven-1p398w.jpg";

  image = pkgs.fetchurl {
    url = imgLink;
    sha256 = "5347bc5a114db8afe9d189682a75565e8d0bc46e003f714879d6957729224335";
  };
in
pkgs.stdenv.mkDerivation {
  name = "sddm-theme";
  src = pkgs.fetchFromGitHub {
    owner = "MarianArlt";
    repo = "sddm-sugar-dark";
    rev = "ceb2c455663429be03ba62d9f898c571650ef7fe";
    sha256 = "0153z1kylbhc9d12nxy9vpn0spxgrhgy36wy37pk6ysq7akaqlvy";
  };
  installPhase = ''
    mkdir -p $out
    cp -R ./* $out/
    cd $out/
    rm Background.jpg
    cp -r ${image} $out/Background.jpg
   '';
}
