#!/bin/bash

CODESPACES_HOME="/workspaces/.codespaces/.persistedshare/dotfiles"
BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
BREWFILE_PATH="${CODESPACES_HOME}/Brewfile"
LOCAL_CONFIG="${HOME}/.zshenv.local"

echo "Copying dotfiles from ${CODESPACES_HOME} to ${HOME}"
cp "${CODESPACES_HOME}/.tmux.conf" "${HOME}/.tmux.conf"
cp "${CODESPACES_HOME}/.gitconfig" "${HOME}/.gitconfig"
cp "${CODESPACES_HOME}/.agignore" "${HOME}/.agignore"
cp "${CODESPACES_HOME}/.aliases" "${HOME}/.aliases"
cp "${CODESPACES_HOME}/.gemrc" "${HOME}/.gemrc"
cp "${CODESPACES_HOME}/.gitconfig" "${HOME}/.gitconfig"
cp "${CODESPACES_HOME}/.gitignore" "${HOME}/.gitignore"
cp "${CODESPACES_HOME}/.gitmessage" "${HOME}/.gitmessage"
cp "${CODESPACES_HOME}/.nvimrc.bundles" "${HOME}/.nvimrc.bundles"
cp "${CODESPACES_HOME}/.pryrc" "${HOME}/.pryrc"
cp "${CODESPACES_HOME}/.psqlrc" "${HOME}/.psqlrc"
cp "${CODESPACES_HOME}/.tmux.conf" "${HOME}/.tmux.conf"
cp "${CODESPACES_HOME}/.zshenv" "${HOME}/.zshenv"
cp "${CODESPACES_HOME}/.zshrc" "${HOME}/.zshrc"

echo "Copying over vim config"
mkdir -p ${HOME}/.config/nvim
cp nvimrc ${HOME}/.config/nvim/init.vim
cp nvim.coc-settings.json ${HOME}/.config/nvim/coc-settings.json

echo "Changing shell to zsh"
sudo chsh --shell /usr/bin/zsh codespace

echo "Setting up local zsh config"
if [ ! -e $LOCAL_CONFIG ]; then
  cat > $LOCAL_CONFIG <<EOF
source "/usr/local/share/chruby/chruby.sh"
source "/usr/local/share/chruby/auto.sh"
# Add additional work-specific below
EOF
fi

echo "Installing brew"
/bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing brew packages"
${BREW_BIN} bundle install --file="${BREWFILE_PATH}"
${BREW_BIN} cleanup

echo "Install vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
       --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Installing gems"
gem install solargraph
