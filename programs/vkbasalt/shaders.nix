{
  fetchFromGitHub,
  stdenv
}:

let
  pname = "reshade-shaders";
  version = "3b5c595cf0338f02d74b2e72b9a036c211937dc3";

  slim = fetchFromGitHub {
    owner = "crosire";
    repo = pname;
    rev = version;
    hash = "sha256-+kh9dlZ+sEwdvPjlNlueqFWDMJa+lJKtv5U4rCoAJ70=";
  };

  legacy = fetchFromGitHub {
    owner = "crosire";
    repo = pname;
    rev = "08f5feb98dee8cc352cf404938edb73094ffdc36";
    hash = "sha256-fZ4rDpp03yPMFiGneV5SW7MxC/iF8gkLE5neN89XZCE=";
  };

  sweetfx = fetchFromGitHub {
    owner = "CeeJayDK";
    repo = "SweetFX";
    rev = "a792aee788c6203385a858ebdea82a77f81c67f0";
    hash = "sha256-ZGJtPA5TSseuXwwcfGz8y+yP8VFzJUstsjHgdfi7eM8=";
  };

  qUINT = fetchFromGitHub {
    owner = "martymcmodding";
    repo = "qUINT";
    rev = "98fed77b26669202027f575a6d8f590426c21ebd";
    hash = "sha256-nPraJgxDm1N9FIhrv0msI3B3it8uyzk6YoX25WY27gE=";
  };

  depth3d = fetchFromGitHub {
    owner = "BlueSkyDefender";
    repo = "Depth3D";
    rev = "274aeed86db084b14f766369bd551873fa62df3d";
    hash = "sha256-ELrt7qB4ju1ZmgzZWpr6qIfpstvcslFsit5kADvyddU=";
  };

  astrayfx = fetchFromGitHub {
    owner = "BlueSkyDefender";
    repo = "AstrayFX";
    rev = "910e3213a846b34dd65d94e84b61b61fca69dd6d";
    hash = "sha256-QG2Plsq+Sh2eQDX5i7Y88sZYzsdnvf5do7rDPJ/lrDU=";
  };

  otisfx = fetchFromGitHub {
    owner = "FransBouma";
    repo = "OtisFX";
    rev = "3e22b10b1a831a92ed146f9d694412014d0d47fb";
    hash = "sha256-HWytT+8t/P1GNnpsYw/Wx7nXiWOme4gvZzooPZ12Za4=";
  };

  brussell = fetchFromGitHub {
    owner = "brussell1";
    repo = "Shaders";
    rev = "f953d1e497ef257b2af05ae413bf432906cb8bd5";
    hash = "sha256-cZAyG8PugVwJCOqle4rdUcVvYnMi5pnYVjOaceJMgXs=";
  };

  prod80 = fetchFromGitHub {
    owner = "prod80";
    repo = "prod80-ReShade-Repository";
    rev = "1c2ed5b093b03c558bfa6aea45c2087052e99554";
    hash = "sha256-EM9WxpbN0tUB9yjZFwWtY1l8um7jvMfC2eenEl2amF8=";
  };

  niceguy = fetchFromGitHub {
    owner = "mj-ehsan";
    repo = "NiceGuy-Shaders";
    rev = "b81ce5699abcedaa889f044b6473f8569ab40570";
    hash = "sha256-PogtDpZCrPfj7x6UP+IyCbrt+BkmsC526bplEBWXOIk=";
  };
in
stdenv.mkDerivation rec {
  inherit pname version;

  src = slim;

  installPhase = ''
    mkdir -p $out
    cp -r ./* $out

    cp -r ${legacy}/Shaders $out
    cp -r ${legacy}/Textures $out

    cp -r ${sweetfx}/Shaders $out
    cp -r ${sweetfx}/Textures $out

    cp -r ${qUINT}/Shaders $out

    cp -r ${depth3d}/Shaders $out
    cp -r ${depth3d}/Textures $out

    # Gotta copy only Clarity as Overwatch.fhx is causing problems :\
    cp -r ${astrayfx}/Shaders/Clarity.fx $out/Shaders

    cp -r ${otisfx}/Shaders $out
    cp -r ${otisfx}/Textures $out

    cp -r ${brussell}/Shaders $out
    cp -r ${brussell}/Textures $out

    cp -r ${prod80}/Shaders $out
    cp -r ${prod80}/Textures $out

    cp -r ${niceguy}/Shaders $out
    cp -r ${niceguy}/Textures $out
  '';
}
