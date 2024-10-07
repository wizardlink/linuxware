{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;
    clock24 = true;
    keyMode = "vi";
    terminal = "screen-256color";

    extraConfig = ''
      # Fix colors
      set -sg terminal-overrides ",*:RGB"
    '';

    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          # Set theme
          set -g @catppuccin_flavour 'frappe'
        '';
      }
    ];
  };
}
