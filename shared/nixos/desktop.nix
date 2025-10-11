{
  pkgs,
  ...
}:

{
  # Enable SDDM.
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "catppuccin-frappe-mauve";
    package = pkgs.kdePackages.sddm;
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

    extraPackages = with pkgs; [
      rocmPackages.clr.icd # OpenGL hwa
    ];
  };

  # Set the default fonts for the system.
  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "IBM Plex Serif" ];
      sansSerif = [ "IBM Plex Sans" ];
      monospace = [ "IBM Plex Mono" ];
    };
  };

  # Enable Thunar and it's dependencies
  programs.thunar = {
    enable = true;
    plugins = with pkgs.xfce; [ thunar-archive-plugin ];
  };
  programs.xfconf.enable = true; # For configuring
  services.gvfs.enable = true; # For mounting drives, trash, etc.
  services.tumbler.enable = true; # Thumbnail support

  # Enable KDEConnect
  programs.kdeconnect = {
    enable = true;
    package = pkgs.kdePackages.kdeconnect-kde;
  };

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

  environment.sessionVariables = {
    # Set env for Fcitx5
    QMODIFIERS = "@im=fcitx5";
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    xclip
    zoxide
    (catppuccin-sddm.override # So SDDM finds the theme files.
      {
        flavor = "frappe";
        font = "IBM Plex Sans";
        fontSize = "11";
        # FIXME: Cannot set custom background anymore, tracking in https://github.com/NixOS/nixpkgs/issues/442758
        # background = "${../../assets/sddm/Background.jpg}";
        loginBackground = true;
      }
    )

    ## Libraries
    libsForQt5.qt5.qtgraphicaleffects
    libsForQt5.qt5.qtquickcontrols2
  ];
}
