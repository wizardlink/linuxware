{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # CORE
    git
    emacs
    ripgrep

    # Optional for DOOM
    clang
    coreutils
    fd

    pandoc # For org-pandoc
    texliveFull # for latex conversions
    (aspellWithDicts (
      dicts: with dicts; [
        en
        pt_BR
      ]
    )) # for flyspell
    gnuplot_qt # for plotting graphs
    ledger # for accounting and org-ledger
    gzip # Otherwise random errors occur from the onChange script
  ];

  # Neatly place the configuration files for doom in their right place.
  xdg.configFile."doom" = {
    source = ./doom;
    recursive = true;
  };
}
