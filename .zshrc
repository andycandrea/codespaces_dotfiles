# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of oh-my-zsh theme to load (others in ~/.oh-my-zsh/themes/)
ZSH_THEME='sporty_256'

# Use case-sensitive completion.
CASE_SENSITIVE='true'

# oh-my-zsh plugins
plugins=(bundler git rails)

source $ZSH/oh-my-zsh.sh

set shell=zsh

[[ -f ~/.aliases ]] && source ~/.aliases

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Uncomment to start tmux in a new shell
# if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
#   tmux new-session -A -s default
# fi
