{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "IBMPlexMono"
        "NerdFontsSymbolsOnly"
      ];
    })
    ibm-plex
    libsForQt5.qtstyleplugin-kvantum
    libsForQt5.qtwayland
    qt6Packages.qtstyleplugin-kvantum
    qt6Packages.qtwayland
  ];

  home.file = {
    # Cattpuccin theme for fish shell.
    ".config/fish/themes/Catppuccin-Frappe.theme".source = ./theming/Catppuccin-Frappe.theme;

    ## Kvantum's theme configuration.
    ".config/Kvantum/catppuccin-frappe-lavender" = {
      source = "${
        pkgs.catppuccin-kvantum.override {
          accent = "lavender";
          variant = "frappe";
        }
      }/share/Kvantum/catppuccin-frappe-lavender";
    };

    ".config/Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=catppuccin-frappe-lavender
    '';
    ##

    ## Themeing configuration for qt5 and qt6
    ".config/qt5ct/colors".source = ./theming/qt5ct;

    ".config/qt6ct/colors".source = ./theming/qt5ct; # We use the qt5ct because it's the SAME spec
    ##

    ".local/share/SpeedCrunch/color-schemes/catppuccin-frappe.json" = {
      recursive = true;
      source = builtins.fetchurl {
        url = "https://raw.githubusercontent.com/catppuccin/speedcrunch/34f2b382de0188d2fd85f59a8a366f313fc30a71/themes/catppuccin-frappe.json";
        sha256 = "sha256:0imx5a53p3ls5kddplgr7mbpbidrmzl9qiwpv7r8jjmsf8yxs0i4";
      };
    };
  };

  home.pointerCursor = {
    package = pkgs.catppuccin-cursors.frappeLavender;
    name = "catppuccin-frappe-lavender-cursors";

    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  # Configure GTK.
  gtk = {
    enable = true;

    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = true;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override { color = "violet"; };
    };
  };

  # Configure QT
  qt = {
    enable = true;
    platformTheme.name = "qtct";
  };
}
