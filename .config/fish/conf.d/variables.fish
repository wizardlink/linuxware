fish_add_path /home/wizardlink/.local/share/scripts \
	/home/wizardlink/.config/emacs/bin \
	/home/wizardlink/.spicetify \
	/home/wizardlink/.nimble/bin \
	/home/wizardlink/.cargo/bin \
	/home/wizardlink/.local/bin \
	/lib/flatpak/exports/bin

# Set the default editor
set -x EDITOR lvim

# Configure FZF
set -x FZF_DEFAULT_OPTS '--color=fg:#f8f8f2,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4 --layout=reverse --height 50%'

# Remove welcome message
set -x fish_greeting ''
