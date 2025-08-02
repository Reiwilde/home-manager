#!/usr/bin/env zsh

if [[ "$(lsb_release -si)" == 'Fedora' ]]; then
  # uwsm
  if [[ ! -d "$XDG_CACHE_HOME/uwsm" ]]; then
    mkdir -p "$XDG_CACHE_HOME/uwsm"
  fi
  
  if [[ -z $SSH_TTY ]] && uwsm check may-start -g 0 >> /dev/null; then
    date="$(date +%Y-%m-%d+%H:%M:%S)"
    exec uwsm start hyprland-uwsm.desktop &> $XDG_CACHE_HOME/uwsm/uwsm.$date.log
  fi
fi

# ssh-agent
if [[ -z $SSH_TTY ]]; then
  export SSH_ASKPASS='ssh-askpass'
  export SSH_ASKPASS_REQUIRE='force'
  eval "$(ssh-agent -s)" 1> /dev/null
fi
