{ fetchFromGitHub
, flavor ? "Mocha"
, lib
, stdenvNoCC
}:
let
  validFlavors = [ "Frappe" "Latte" "Macchiato" "Mocha" ];
  pname = "catppucin-qt5ct";
in
lib.checkListOfEnum "${pname}: flavors" validFlavors [ flavor ]

  stdenvNoCC.mkDerivation
{
  inherit pname;
  version = "unstable-2023-10-24";

  src = fetchFromGitHub {
    owner = "catppuccin";
    repo = "qt5ct";
    rev = "89ee948e72386b816c7dad72099855fb0d46d41e";
    sha256 = "sha256-t/uyK0X7qt6qxrScmkTU2TvcVJH97hSQuF0yyvSO/qQ=";
  };

  nativeBuildInputs = [ ];
  buildInputs = [ ];

  postPatch = ''
    export HOME=$(mktemp -d)
    cp -r themes/* $HOME/.config/qt5ct/colors/
  '';

  meta = with lib; {
    description = "Catppuccin for qt5ct";
    homepage = "https://github.com/catppuccin/qt5ct";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
