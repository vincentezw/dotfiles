#!/usr/bin/env bash

### START-OF-ICON-MAP
function __icon_map() {
    case "$1" in
   "Affinity Photo")
        icon_result=":affinity_photo:"
        ;;
   "Affinity Photo 2")
        icon_result=":affinity_photo_2:"
        ;;
   "Alacritty")
        icon_result=":alacritty:"
        ;;
   "Alfred")
        icon_result=":alfred:"
        ;;
   "App Store")
        icon_result=":app_store:"
        ;;
   "Audacity")
        icon_result=":audacity:"
        ;;
   "BetterTouchTool")
        icon_result=":bettertouchtool:"
        ;;
   "Bitwarden")
        icon_result=":bit_warden:"
        ;;
   "Calibre")
        icon_result=":book:"
        ;;
   "Calculator" | "Calculette")
        icon_result=":calculator:"
        ;;
   "Calendar" | "日历" | "Fantastical" | "Cron" | "Amie" | "Calendrier" | "Notion Calendar")
        icon_result=":calendar:"
        ;;
   "Code" | "Code - Insiders")
        icon_result=":code:"
        ;;
   "Color Picker" | "数码测色计")
        icon_result=":color_picker:"
        ;;
   "Default")
        icon_result=":default:"
        ;;
   "Discord" | "Discord Canary" | "Discord PTB")
        icon_result=":discord:"
        ;;
   "Docker" | "Docker Desktop")
        icon_result=":docker:"
        ;;
   "FaceTime" | "FaceTime 通话")
        icon_result=":face_time:"
        ;;
   "Figma")
        icon_result=":figma:"
        ;;
   "Finder" | "访达")
        icon_result=":finder:"
        ;;
   "Firefox")
        icon_result=":firefox:"
        ;;
   "Firefox Developer Edition" | "Firefox Nightly")
        icon_result=":firefox_developer_edition:"
        ;;
   "System Preferences" | "System Settings" | "系统设置" | "Réglages Système")
        icon_result=":gear:"
        ;;
   "GitHub Desktop")
        icon_result=":git_hub:"
        ;;
   "Chromium" | "Google Chrome" | "Google Chrome Canary")
        icon_result=":google_chrome:"
        ;;
   "Home Assistant")
        icon_result=":home_assistant:"
        ;;
   "iTerm" | "iTerm2")
        icon_result=":iterm:"
        ;;
   "Keynote" | "Keynote 讲演")
        icon_result=":keynote:"
        ;;
   "kitty")
        icon_result=":kitty:"
        ;;
   "Canary Mail" | "HEY" | "Mail" | "Mailspring" | "MailMate" | "Superhuman" | "Spark" | "邮件")
        icon_result=":mail:"
        ;;
   "Maps" | "Google Maps")
        icon_result=":maps:"
        ;;
   "Messages" | "信息" | "Nachrichten")
        icon_result=":messages:"
        ;;
   "Neovide" | "neovide")
        icon_result=":neovide:"
        ;;
   "Neovim" | "neovim" | "nvim")
        icon_result=":neovim:"
        ;;
   "Numbers")
        icon_result=":numbers:"
        ;;
   "1Password")
        icon_result=":one_password:"
        ;;
   "ChatGPT")
        icon_result=":openai:"
        ;;
   "Pages")
        icon_result=":pages:"
        ;;
   "Parallels Desktop")
        icon_result=":parallels:"
        ;;
   "Preview" | "预览" | "Skim" | "zathura" | "Aperçu")
        icon_result=":pdf:"
        ;;
   "Pi-hole Remote")
        icon_result=":pihole:"
        ;;
   "Podcasts" | "播客")
        icon_result=":podcasts:"
        ;;
   "Postman")
        icon_result=":postman:"
        ;;
   "qutebrowser")
        icon_result=":qute_browser:"
        ;;
   "Safari" | "Safari浏览器" | "Safari Technology Preview")
        icon_result=":safari:"
        ;;
   "Sequel Ace")
        icon_result=":sequel_ace:"
        ;;
   "Slack")
        icon_result=":slack:"
        ;;
   "Spotify")
        icon_result=":spotify:"
        ;;
   "Spotlight")
        icon_result=":spotlight:"
        ;;
   "Sublime Text")
        icon_result=":sublime_text:"
        ;;
   "Terminal" | "终端")
        icon_result=":terminal:"
        ;;
   "Typora")
        icon_result=":text:"
        ;;
   "Thunderbird")
        icon_result=":thunderbird:"
        ;;
   "Todoist")
        icon_result=":todoist:"
        ;;
   "Tower")
        icon_result=":tower:"
        ;;
   "VLC")
        icon_result=":vlc:"
        ;;
   "VSCodium")
        icon_result=":vscodium:"
        ;;
   "Warp")
        icon_result=":warp:"
        ;;
   "WebStorm")
        icon_result=":web_storm:"
        ;;
   "WezTerm")
        icon_result=":wezterm:"
        ;;
   "WhatsApp" | "‎WhatsApp")
        icon_result=":whats_app:"
        ;;
   "Xcode")
        icon_result=":xcode:"
        ;;
   "zoom.us")
        icon_result=":zoom:"
        ;;
    *)
        icon_result=":default:"
        ;;
    esac
}
### END-OF-ICON-MAP
__icon_map "$1"
echo "$icon_result"
