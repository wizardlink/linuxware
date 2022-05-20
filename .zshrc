### variables {{{
export ZSH_THEME="imajes"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

export ENABLE_CORRECTION="true"       # Command auto-correction

export COMPLETION_WAITING_DOTS="true" # Display red dots whilst waiting for completion

export ZSH_DISABLE_COMPFIX="true"     # Disable checks for unsafe directories
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

source $ZSH/oh-my-zsh.sh
### }}}

### alias {{{

# zsh
alias zshrc="$EDITOR ~/.zshrc"
alias zshreload='source ~/.zshrc'

# nvim
alias nvimrc="$EDITOR ~/.config/nvim/init.vim"
alias e="$EDITOR"

# tmux
alias ta='tmux attach'

# script
alias uscript="cd ~/.local/share/scripts"
alias cfsink="~/.local/share/scripts/create_feedback_sinks.sh"
alias dfsink="~/.local/share/scripts/delete_feedback_sinks.sh"

# make it easier to call bpytop
alias status="bpytop"
### }}}

### functions {{{
function fe() { fzf | xargs -ro -I % $EDITOR % ;}
### }}}
