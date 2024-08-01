{ pkgs, lib, ... }:

let
  packagesNeeded = with pkgs; [
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
in
{
  home.packages = packagesNeeded;

  # Neatly place the configuration files for doom in their right place.
  xdg.configFile."doom" = {
    source = ./doom;
    recursive = true;

    onChange = # sh
      ''
        # Need to set this so DOOM can find all binaries.
        export PATH="${lib.strings.concatMapStrings (x: x + "/bin:") packagesNeeded}$PATH"

        if [ ! -d "$HOME/.emacs.d" ]; then
          git clone https://github.com/hlissner/doom-emacs $HOME/.emacs.d
          $HOME/.emacs.d/bin/doom install
        else
          # Needed to apply the configuration changes.
          $HOME/.emacs.d/bin/doom sync
        fi
      '';
  };
}
