{
  pkgs,
  hyprland,
  ...
}:

let
  hyprland-pkgs = hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  environment.sessionVariables = {
    # Set env for Fcitx5
    QMODIFIERS = "@im=fcitx5";
  };

  # Enable SDDM.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-frappe";
    package = pkgs.kdePackages.sddm;
  };

  # Enable Hyprland
  programs.hyprland = {
    enable = true;

    package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  # Enable XDG Desktop Portals.
  xdg.portal = {
    enable = true;

    config = {
      common = {
        default = [ "wlr" ];
      };
    };
  };

  # Needed for home-manager
  environment.pathsToLink = [
    "/share/xdg-desktop-portal"
    "/share/applications"
  ];

  # Enable OpenGL.
  hardware.graphics = {
    enable = true;
    enable32Bit = true;

    package = hyprland-pkgs.mesa.drivers;
    package32 = hyprland-pkgs.pkgsi686Linux.mesa.drivers;

    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenGL hwa
    ];
  };

  # Enable Thunar and it's dependencies
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin ];
  };
  programs.xfconf.enable = true; # For configuring
  services.gvfs.enable = true; # For mounting drives, trash, etc.
  services.tumbler.enable = true; # Thumbnail support

  # Enable the Fcitx5 IME
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [
        fcitx5-mozc
        fcitx5-gtk
        fcitx5-catppuccin
      ];

      quickPhrase = {
        proud = "<(￣︶￣)>";
      };

      waylandFrontend = true;
    };
  };
}
