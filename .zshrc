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
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
source /opt/homebrew/opt/chruby/share/chruby/auto.sh

# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
