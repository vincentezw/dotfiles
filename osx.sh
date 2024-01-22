#!/bin/bash
# Check if on macOS
curl -sS https://starship.rs/install.sh | sh -s -- -f

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
