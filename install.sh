mkdir -p ~/.config
ln -sf "${HOME}/dotfiles/.config/nvim" "${HOME}/.config/nvim"
echo "source ~/dotfiles/alias.zsh" >> ${HOME}/.zshrc
