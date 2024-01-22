#!/bin/bash
curl -sS https://starship.rs/install.sh | sh
mkdir -p ~/.config
ln -s ~/dotfiles/.zshrc ${HOME}/.zshrc
ln -sf "${HOME}/dotfiles/.config/nvim" "${HOME}/.config/nvim"
ln -sf "${HOME}/dotfiles/.config/starship.toml" "${HOME}/.config/starship.toml"

# Install Neovim plugins
gem install neovim
npm install -g neovim

if [ -n "$SPIN" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  apt_packages=("exa" "fonts-firacode")  # Add your list of packages
  for package in "${apt_packages[@]}"; do
    if ! dpkg -l | grep -q "$package"; then
      sudo apt-get install -y "$package"
    else
      echo "$package is already installed."
    fi
  done
fi

# Check if on macOS
if [[ $(uname) == "Darwin" ]]; then
  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  brew tap homebrew/cask-fonts

  # Install packages using Homebrew
  brew_packages=(
    "fzf"
    "font-victor-mono-nerd-font"
    "exa"
    "zsh-autosuggestions"
    "zsh-syntax-highlighting"
  )
  for package in "${brew_packages[@]}"; do
    if ! brew list "$package" &> /dev/null; then
      echo "Installing $package..."
      brew install "$package"
    else
      echo "$package is already installed."
    fi
  done
  $(brew --prefix)/opt/fzf/install
fi
