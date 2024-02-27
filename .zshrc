alias vim="nvim"
alias vi="nvim"

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
# ENABLE_CORRECTION="true"
plugins=(
  1password
  colored-man-pages
  git
  macos
  npm
  rails
  ruby
  systemd
  starship
  yarn
)
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

if [[ -d "$HOME/.rbenv/bin" ]]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if [[ -d "/opt/dev/bin" ]]; then
  export PATH="/opt/dev/bin:$PATH"
fi


[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ -n "$SPIN" ]; then
  alias ls="exa --long --header --icons"
else
  alias ls="exa --long --header --icons --git"
fi
