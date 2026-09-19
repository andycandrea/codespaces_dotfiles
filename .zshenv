# use nvim as the visual editor
export VISUAL=nvim
export EDITOR=$VISUAL
export GIT_EDITOR=$VISUAL

export PATH=".git/safe/../../bin:$HOME/.npm-global/bin:$PATH"

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# Things not to keep in git
[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets

# Use ripgrep for fzf for performance
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit
autoload -U +X bashcompinit && bashcompinit

# Local config
[[ -f ~/.zshenv.local ]] && source ~/.zshenv.local

# Things not to keep in git
[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets
