{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      ## Set vim mode
      set -g fish_key_bindings fish_vi_key_bindings

      # Configure FZF
      set -x FZF_DEFAULT_OPTS '--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --layout=reverse --height 50%'

      # Remove welcome message
      set -x fish_greeting ""

      ## Add directories to $PATH
      fish_add_path /home/wizardlink/.local/share/scripts \
          /home/wizardlink/.config/emacs/bin \
          /home/wizardlink/.spicetify \
          /home/wizardlink/.nimble/bin \
          /home/wizardlink/.cargo/bin \
          /home/wizardlink/.local/bin \
          /lib/flatpak/exports/bin \
          /home/wizardlink/.local/share/scripts/burrito
    '';

    shellAbbrs = {
      z = "zoxide";
    };

    functions = {
      fish_prompt.body = ''
        set_color CC241D
        echo '&' (set_color normal)
      '';

      fzf_edit.body = ''
        fzf --multi --bind 'enter:become(nvim {+})'
      '';
    };
  };
}
