### variables {{{
ZSH_THEME="imajes"

DISABLE_UPDATE_PROMPT="true"   # Auto update

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

ENABLE_CORRECTION="true"       # Command auto-correction

COMPLETION_WAITING_DOTS="true" # Display red dots whilst waiting for completion
### }}}¶

### ohmyzsh {{{
plugins=(
	fzf
	git
	sudo
	vi-mode
	zsh-autosuggestions
	zsh-completions
	zsh-syntax-highlighting
)

autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh
### }}}

### alias {{{

# zsh
alias zshrc="$EDITOR ~/.zshrc"
alias zshreload='source ~/.zshrc'
alias ohmyzsh="$EDITOR ~/.config/.oh-my-zsh"

# nvim
alias nvimrc="$EDITOR ~/.config/nvim/init.vim"
alias e="$EDITOR"

# tmux
alias ta='tmux attach'

# script
alias uscript="cd ~/.local/share/scripts"
alias cfsink="~/.local/share/scripts/create_feedback_sinks.sh"
alias dfsink="~/.local/share/scripts/delete_feedback_sinks.sh"
### }}}

### functions {{{
function fe() { fzf | xargs -ro -I % $EDITOR % ;}
### }}}
