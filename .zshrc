alias vim="nvim"
alias vi="nvim"

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
source ~/dotfiles/wezterm-shell-integration.sh

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

tt() {
  local title="${1:-$(basename "$PWD")}"
  if [[ -z "${TMUX-}" ]]; then
    printf "\033]1337;SetUserVar=%s=%s\007" "tab_title" "$(echo -n "$title" | base64)"
  else
    tmux rename-session "$title"
    printf "\033Ptmux;\033\033]1337;SetUserVar=%s=%s\007\033\\" "tab_title" "$(echo -n "$title" | base64)"
  fi
}

clipboard() {
  local data
  data=$(cat)
  printf "\033]52;c;$(printf '%s' "$data" | base64 | tr -d '\n')\a"
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[[ -f /opt/dev/sh/chruby/chruby.sh ]] && { type chruby >/dev/null 2>&1 || chruby () { source /opt/dev/sh/chruby/chruby.sh; chruby "$@"; } }

[[ -x /opt/homebrew/bin/brew ]] && eval $(/opt/homebrew/bin/brew shellenv)

[ -f /opt/dev/dev.sh ] && source /opt/dev/dev.sh

if [ -n "$SPIN" ]; then
  alias ls="eza --long --header --icons"
else
  alias ls="eza --long --header --icons --git"
fi

export EDITOR=nvim
export MANPAGER='nvim +Man!'

# step notes with nb.sh if it's not already set up
if [ ! -d "$HOME/.nb" ]; then
  # ${HOME}/dotfiles/nb-setup.sh
fi

if [[ -d "/opt/dev/bin" ]]; then
  PATH="/opt/dev/bin:$PATH"
fi
if [[ -d "$HOME/.cargo/bin" ]]; then
  PATH="$HOME/.cargo/bin:$PATH"
fi
export PATH="$HOME/.local/bin:$PATH"
export PATH="/home/vincent/.local/share/gem/ruby/3.0.0/bin:/usr/bin:$PATH"
