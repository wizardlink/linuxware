{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;

    home.packages = with pkgs; [
      # Optional for DOOM
      clang
      coreutils
      fd
    ];
  };
}
