mkdir -p ~/.config
echo "source ~/dotfiles/alias.zsh" >> ${HOME}/.zshrc
gem install neovim
npm install -g neovim
if [ -n "$SPIN" ]; then
  ln -sf "${HOME}/gitstatusd-linux-x86_64" "${HOME}/.cache/gitstatus/gitstatusd-linux-x86_64"
  ln -sf "${HOME}/dotfiles/.config/nvim" "${HOME}/.config/nvim"
  if ! dpkg -l | grep -q fonts-firacode; then
    sudo apt-get install -y fonts-firacode
  fi

  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
  echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc
  ln -sf "${HOME}/dotfiles/p10k.zsh" "${HOME}/.p10k.zsh"

  if [ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]; then
    echo 'source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> ~/.zshrc
  fi
  if [ -f "/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh" ]; then
    echo 'source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> ~/.zshrc
  fi
  echo '[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh' >> ~/.zshrc
fi
