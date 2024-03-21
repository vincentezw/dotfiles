#!/bin/bash
mkdir -p ~/.config
mkdir -p ~/.tmux/plugins
ln -sf "${HOME}/dotfiles/.config/nvim" "${HOME}/.config/nvim"
ln -sf "${HOME}/dotfiles/.config/starship.toml" "${HOME}/.config/starship.toml"
ln -s "${HOME}/dotfiles/.tmux.conf" "${HOME}/.tmux.conf"
ln -s "${HOME}/dotfiles/.tmux/vincent-theme.tmux" "${HOME}/.tmux/vincent-theme.tmux"

if [ -n "$SPIN" ]; then
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  sudo apt-get update

  apt_packages=("exa" "tmux" "fzf" "neovim")  # Add your list of packages
  for package in "${apt_packages[@]}"; do
    if ! dpkg -l | grep -q "$package"; then
      sudo apt-get install -y "$package"
    else
      echo "$package is already installed."
    fi
  done
fi

if [ -n "$SPIN" ]; then
  sh ${HOME}/dotfiles/starship.sh -f
  sh ${HOME}/dotfiles/oh-my-zsh.sh --unattended --keep-zshrc

  gem_user_install_dir=$(gem environment | grep -oP 'USER INSTALLATION DIRECTORY: \K.*')
  gem_bin_path="$gem_user_install_dir/bin"
  gem install --user neovim ruby-lsp

  if [ -d "$gem_bin_path" ]; then
    echo "export PATH=\"$gem_bin_path:\$PATH\"" >> ~/.zshrc
    echo "Gem bin path added to PATH."
  fi
else
  # npm install -g neovim
  sudo gem install neovim
fi
npm install -g neovim

ln -sf ~/dotfiles/.zshrc ${HOME}/.zshrc
ln -sf ~/dotfiles/.wezterm.lua ${HOME}/.wezterm.lua

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
