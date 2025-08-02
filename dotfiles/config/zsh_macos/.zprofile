#!/usr/bin/env zsh

# brew
if [[ "$(uname -m)" == 'arm64' ]] && [[ -f "/opt/homebrew/bin/brew" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ "$(uname -m)" == 'i386' ]] && [[ -f "/usr/local/bin/brew" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ssh
export SSH_ASKPASS='ssh-askpass'
export SSH_ASKPASS_REQUIRE='force'

# ssh-agent
eval "$(ssh-agent -s)" 1> /dev/null
