{ pkgs, lib, ... }:

{
  programs.emacs.enable = true;

  home.packages = with pkgs; [
    # Optional for DOOM
    clang
    coreutils
    fd

    pandoc # For org-pandoc
  ];

  # Neatly place the configuration files for doom in their right place.
  xdg.configFile."doom" =
    let
      # What DOOM needs to be able to install/sync.
      packagesNeeded = with pkgs; [
        git
        emacs
        ripgrep
      ];
    in
    {
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
