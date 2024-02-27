#!/usr/bin/env bash
get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  value="$(tmux show-option -gqv "$option")"

  if [ -n "$value" ]; then
    echo "$value"
  else
    echo "$default"
  fi
}

set() {
  local option=$1
  local value=$2
  tmux_commands+=(set-option -gq "$option" "$value" ";")
}

setw() {
  local option=$1
  local value=$2
  tmux_commands+=(set-window-option -gq "$option" "$value" ";")
}

unset_option() {
  local option=$1
  local value=$2
  tmux_commands+=(set-option -gu "$option" ";")
}

main() {
  colour_bg="#121212"        # Closest to base00_nvim
  thm_surface="#1f1d2e"     # Closest to base01_nvim
  thm_muted="#6e6a86"       # Closest to base03_nvim
  thm_text="#e0def4"        # Closest to base04_nvim
  thm_love="#CE27BD"        # Closest to base05_nvim
  thm_iris="#ffffff"        # Closest to base06_nvim
  colour_turqois="#08bdba"        # Closest to base07_nvim
  thm_rose="#3ddbd9"        # Closest to base08_nvim
  colour_blue="#78a9ff"        # Closest to base09_nvim
  thm_hl_low="#ee5396"      # Closest to base0A_nvim
  thm_hl_med="#33b1ff"      # Closest to base0B_nvim
  thm_hl_high="#ff7eb6"     # Closest to base0C_nvim
  thm_foam="#42be65"        # Closest to base0D_nvim
  thm_subtle="#be95ff"      # Closest to base0E_nvim
  thm_overlay="#82cfff"     # Closest to base0F_nvim
  colour_bubble="#2c3e50"
  colour_bubble_text="#06a4c7"
  # Aggregating all commands into a single array
  local tmux_commands=()

  # Status bar
  set "status" "on"
  set status-style "fg=$colour_blue,bg=$colour_bg"
  # set monitor-activity "on"
  set status-justify "left"
  set status-left-length "300"
  set status-right-length "400"

  # Theoretically messages (need to figure out color placement)
  set message-style "fg=$thm_muted,bg=$colour_bg"
  set message-command-style "fg=$colour_bg,bg=$colour_turqois"

  # Pane styling
  set pane-border-style "fg=$thm_hl_high"
  set pane-active-border-style "fg=$colour_turqois"
  set display-panes-active-colour "${thm_text}"
  set display-panes-colour "${colour_turqois}"

  # Windows
  setw window-status-style "fg=${thm_iris},bg=${colour_bg}"
  setw window-status-activity-style "fg=${colour_bg},bg=${thm_rose}"
  setw window-status-current-style "fg=${colour_turqois},bg=${colour_bg}"

  local readonly date="$(get_tmux_option "@vincent_theme_date" "")"
  local readonly time="$(get_tmux_option "@vincent_theme_time" "")"
  local left_separator="  "

  local field_separator="$(get_tmux_option "@vincent_theme_field_separator" " | " )"

  local spacer = " "
  # I know, stupid, right? For some reason, spaces aren't consistent

  local readonly show_window=" #[fg=$thm_love]  #[fg=$thm_rose]#W$spacer"
  local readonly show_window_in_window_status_current="$spacer #[fg=$thm_love]󰶭  #[fg=$thm_overlay]#I#[fg=$thm_overlay,bg=""]$left_separator#[fg=$thm_overlay,bg=""]#W"
  local readonly show_session="#[fg=$thm_love]  #[fg=$thm_overlay]#S "
  local readonly show_date_time="$spacer #[fg=$colour_bubble] #[bg=$colour_bubble fg=$thm_love] 󰥔  $spacer#[fg=$colour_bubble_text]$date $spacer $time $spacer#[bg=$colour_bg fg=$colour_bubble] $spacer"
  local show_music="$spacer #[fg=$colour_bubble] #[bg=$colour_bubble fg=$thm_love] 󰎆 #[fg=$colour_bubble_text]#{music_status} #{artist}: #{track} $spacer#[bg=$colour_bg fg=$colour_bubble]$spacer"
  local weather="#[fg=$colour_bubble]#[bg=$colour_bubble fg=$colour_bubble_text] #{weather} #[bg=$colour_bg fg=$colour_bubble]$spacer "
  window_status_format=$show_window_in_window_status
  window_status_current_format=$show_window_in_window_status_current
  setw window-status-format "$window_status_format"
  setw window-status-current-format "$window_status_current_format"

  local left_column=$show_session$show_window
  # We set the sections
  set status-left "$left_column"
  if [ -n "$SSH_CONNECTION" ]; then
    set status-right "#[fg=$thm_overlay] ssh"
  else
    set status-right "$weather$show_music$show_date_time"
  fi
  setw window-status-separator "  "

  # NOTE: Dont remove this, it can be useful for references
  # setw window-status-format "$window_status_format"
  # setw window-status-current-format "$window_status_current_format"

  setw clock-mode-colour "${thm_love}"
  setw mode-style "fg=${colour_turqois}"

  # Call everything to action
  tmux "${tmux_commands[@]}"
}

main "$@"
