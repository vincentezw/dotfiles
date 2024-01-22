#!/bin/bash
mkdir -p ~/.config
ln -sf "${HOME}/dotfiles/.config/nvim" "${HOME}/.config/nvim"
ln -sf "${HOME}/dotfiles/.config/starship.toml" "${HOME}/.config/starship.toml"

# Install Neovim plugins
sudo gem install neovim
npm install -g neovim

if [ -n "$SPIN" ]; then
  apt_packages=("exa" "fonts-firacode" "fzf")  # Add your list of packages
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
fi

ln -sf ~/dotfiles/.zshrc ${HOME}/.zshrc
