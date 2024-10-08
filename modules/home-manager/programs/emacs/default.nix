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
    (aspellWithDicts (
      dicts: with dicts; [
        en
        pt_BR
      ]
    )) # for flyspell
    gnuplot_qt # for plotting graphs
    languagetool # for grammar
    ledger # for accounting and org-ledger
    gzip # Otherwise random errors occur from the onChange script
  ];

  # Neatly place the configuration files for doom in their right place.
  xdg.configFile."doom" = {
    source = ./doom;
    recursive = true;
  };
}
