alias vim="nvim"
alias vi="nvim"
alias ssh="kitty +kitten ssh"
alias clipboard="kitty +kitten clipboard"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
  colored-man-pages
  git
  npm
  rails
  ruby
  systemd
  starship
)
if [ -z "$SPIN" ]; then
  plugins+=(macos)
  plugins+=(1password)
  plugins+=(yarn)
fi
source $ZSH/oh-my-zsh.sh

base_paths=(
  "/opt/homebrew/share"
  "/usr/local/share"
  "/usr/share"
  "/usr/share/zsh/plugins"
)

command_paths=(
  "zsh-autosuggestions/zsh-autosuggestions.zsh"
  "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)

for base_path in $base_paths; do
  for command_path in $command_paths; do
    full_path="$base_path/$command_path"
    if [[ -s $full_path ]]; then
      source $full_path
    fi
  done
done

if command -v rbenv &> /dev/null; then
  eval "$(rbenv init - zsh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

if [ -n "$SPIN" ]; then
  alias ls="eza --long --header --icons"
else
  alias ls="eza --long --header --icons --git"
fi

# step notes with nb.sh if it's not already set up
if [ ! -d "$HOME/.nb" ]; then
  # ${HOME}/dotfiles/nb-setup.sh
fi

if [[ -d "/opt/dev/bin" ]]; then
  PATH="/opt/dev/bin:$PATH"
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/vincent/.local/share/gem/ruby/3.0.0/bin:/usr/bin:$PATH"
