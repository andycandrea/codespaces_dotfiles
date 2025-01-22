#!/bin/bash

CODESPACES_HOME="/workspaces/.codespaces/.persistedshare/dotfiles"
BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
BREWFILE_PATH="${CODESPACES_HOME}/Brewfile"
/bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
${BREW_BIN} bundle install --file="${BREWFILE_PATH}"

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

cp "${CODESPACES_HOME}.tmux.conf" "${HOME}/.tmux.conf"
cp "${CODESPACES_HOME}.gitconfig" "${HOME}/.gitconfig"
cp "${CODESPACES_HOME}.agignore" "${HOME}/.agignore"
cp "${CODESPACES_HOME}.aliases" "${HOME}/.aliases"
cp "${CODESPACES_HOME}.gemrc" "${HOME}/.gemrc"
cp "${CODESPACES_HOME}.gitconfig" "${HOME}/.gitconfig"
cp "${CODESPACES_HOME}.gitignore" "${HOME}/.gitignore"
cp "${CODESPACES_HOME}.gitmessage" "${HOME}/.gitmessage"
cp "${CODESPACES_HOME}.nvimrc.bundles" "${HOME}/.nvimrc.bundles"
cp "${CODESPACES_HOME}.pryrc" "${HOME}/.pryrc"
cp "${CODESPACES_HOME}.psqlrc" "${HOME}/.psqlrc"
cp "${CODESPACES_HOME}.tmux.conf" "${HOME}/.tmux.conf"
cp "${CODESPACES_HOME}.zshenv" "${HOME}/.zshenv"
cp "${CODESPACES_HOME}.zshrc" "${HOME}/.zshrc"

# Install vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Bring in our custom neovim config
mkdir -p ${HOME}/.config/nvim
cp nvimrc ${HOME}/.config/nvim/init.vim
cp nvim.coc-settings.json ${HOME}/.config/nvim/coc-settings.json
sudo chsh --shell "/usr/bin/zsh" "$(whoami)"

local_config="${HOME}/.zshenv.local"
if [ ! -e $local_config ]; then
  cat > $local_config <<EOF
export PANORAMA_TOP=/workspaces
# These files are sourced in our devcontainer's on-create.sh, but that's for
# bash.
SCHOOL_SUPPLIES_HOME="${PANORAMA_TOP}/school-supplies"
source "/usr/local/share/chruby/chruby.sh"
source "/usr/local/share/chruby/auto.sh"
source "${SCHOOL_SUPPLIES_HOME}/bin/shell_includes.sh"
EOF
fi
