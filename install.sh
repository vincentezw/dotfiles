#!/bin/bash
mkdir -p ~/.config
mkdir -p ~/.tmux/plugins

source_dir="${HOME}/dotfiles/.config"
target_dir="${HOME}/.config"
subdirs=("nvim" "kitty" "hyper")

for subdir in "${subdirs[@]}"; do
  ln -sf "${source_dir}/${subdir}" "${target_dir}/${subdir}"
done
ln -sf "${HOME}/dotfiles/.config/starship.toml" "${HOME}/.config/starship.toml"
ln -s "${HOME}/dotfiles/.tmux.conf" "${HOME}/.tmux.conf"
ln -s "${HOME}/dotfiles/.tmux/vincent-theme.tmux" "${HOME}/.tmux/vincent-theme.tmux"
ln -sf ${HOME}/dotfiles/.zshrc ${HOME}/.zshrc
ln -sf ${HOME}/dotfiles/.npmrc ${HOME}/.npmrc

if [ -n "$SPIN" ]; then
  sudo add-apt-repository -y ppa:neovim-ppa/unstable
  apt_packages=("exa" "tmux" "fzf" "neovim")
  for package in "${apt_packages[@]}"; do
    if ! dpkg -l | grep -q "$package"; then
      sudo apt-get install -y "$package"
    else
      echo "$package is already installed."
    fi
  done

  sh ${HOME}/dotfiles/starship.sh -f
  sh ${HOME}/dotfiles/oh-my-zsh.sh --unattended --keep-zshrc

  gem_user_install_dir=$(gem environment | grep -oP 'USER INSTALLATION DIRECTORY: \K.*')
  gem_bin_path="$gem_user_install_dir/bin"
  # gem install --user neovim ruby-lsp
  gem install --user neovim

  if [ -d "$gem_bin_path" ]; then
    echo "export PATH=\"$gem_bin_path:/usr/bin:\$PATH\"" >> ~/.zshrc
    echo "Gem bin path added to PATH."
  else
    echo "export PATH=\"/usr/bin:\$PATH\"" >> ~/.zshrc
  fi
else
  sudo gem install neovim
fi
npm install -g neovim nb.sh
sudo "$(which nb)" completions install

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

${HOME}/dotfiles/nb-setup.sh
