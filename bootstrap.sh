#!/bin/bash
set -e

DOTFILES_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREW_BIN="/home/linuxbrew/.linuxbrew/bin/brew"
BREWFILE_PATH="${DOTFILES_HOME}/Brewfile"
LOCAL_CONFIG="${HOME}/.zshenv.local"
CURRENT_USER="$(whoami)"

echo "Copying dotfiles from ${DOTFILES_HOME} to ${HOME}"
cp "${DOTFILES_HOME}/.tmux.conf" "${HOME}/.tmux.conf"
cp "${DOTFILES_HOME}/.gitconfig" "${HOME}/.gitconfig"
cp "${DOTFILES_HOME}/.agignore" "${HOME}/.agignore"
cp "${DOTFILES_HOME}/.aliases" "${HOME}/.aliases"
cp "${DOTFILES_HOME}/.gemrc" "${HOME}/.gemrc"
cp "${DOTFILES_HOME}/.gitignore" "${HOME}/.gitignore"
cp "${DOTFILES_HOME}/.gitmessage" "${HOME}/.gitmessage"
cp "${DOTFILES_HOME}/.nvimrc.bundles" "${HOME}/.nvimrc.bundles"
cp "${DOTFILES_HOME}/.pryrc" "${HOME}/.pryrc"
cp "${DOTFILES_HOME}/.psqlrc" "${HOME}/.psqlrc"
cp "${DOTFILES_HOME}/.zshenv" "${HOME}/.zshenv"
cp "${DOTFILES_HOME}/.zshrc" "${HOME}/.zshrc"

echo "Configuring npm global prefix"
mkdir -p "${HOME}/.npm-global"
npm config set prefix "${HOME}/.npm-global"

echo "Copying over vim config"
mkdir -p "${HOME}/.config/nvim"
cp "${DOTFILES_HOME}/nvimrc" "${HOME}/.config/nvim/init.vim"
cp "${DOTFILES_HOME}/nvim.coc-settings.json" "${HOME}/.config/nvim/coc-settings.json"

echo "Installing oh-my-zsh"
RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
  "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Changing shell to zsh"
sudo chsh --shell /usr/bin/zsh "${CURRENT_USER}"

echo "Setting up local zsh config"
if [ ! -e "$LOCAL_CONFIG" ]; then
  cat > "$LOCAL_CONFIG" <<EOF
source "/usr/local/share/chruby/chruby.sh"
source "/usr/local/share/chruby/auto.sh"
EOF
fi

echo "Installing brew"
/bin/bash -c "$(curl --fail --silent --show-error --location https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Installing brew packages"
"${BREW_BIN}" bundle install --file="${BREWFILE_PATH}"
"${BREW_BIN}" cleanup

echo "Install vim-plug"
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim \
       --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
