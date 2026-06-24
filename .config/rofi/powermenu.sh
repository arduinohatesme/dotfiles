#!/usr/bin/env bash

# Current Theme
theme="$HOME/.config/rofi/powermenu-style.rasi"

# CMDs
uptime=$(awk '{printf "%02d:%02d", int($1/3600), int(($1%3600)/60)}' /proc/uptime)
host=$(hostname)

# Options
shutdown='󰐥'
reboot=''
logout='󰍃'
yes=''
no=''

# Rofi CMD
rofi_cmd() {
  rofi -dmenu \
    -p " Uptime: $uptime " \
    -mesg " Uptime: $uptime " \
    -theme ${theme} \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}'
}

# Confirmation CMD
confirm_cmd() {
  rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 450px;}' \
    -theme-str 'mainbox {children: [ "message", "listview" ];}' \
    -theme-str 'listview {columns: 2; lines: 1;}' \
    -theme-str 'element-text {horizontal-align: 0.5;}' \
    -theme-str 'textbox {horizontal-align: 0.5;}' \
    -dmenu \
    -p 'Confirmation' \
    -mesg 'Are you sure?' \
    -theme ${theme}
}

# Ask for confirmation
confirm_exit() {
  echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to rofi dmenu
run_rofi() {
  echo -e "$logout\n$reboot\n$shutdown" | rofi_cmd
}

# Execute Command
run_cmd() {
  selected="$(confirm_exit)"
  if [[ "$selected" == "$yes" ]]; then
    if [[ $1 == '--shutdown' ]]; then
      systemctl poweroff
    elif [[ $1 == '--reboot' ]]; then
      systemctl reboot
    elif [[ $1 == '--logout' ]]; then
      command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'
    fi
  else
    exit 0
  fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
$shutdown)
  run_cmd --shutdown
  ;;
$reboot)
  run_cmd --reboot
  ;;
$logout)
  run_cmd --logout
  ;;
esac
