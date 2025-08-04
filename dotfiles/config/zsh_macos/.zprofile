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

# local/bin
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [[ "$(uname -m)" == 'arm64' ]] && [[ -d "$HOME/.local/bin/arm64" ]]; then
  export PATH="$HOME/.local/bin/arm64:$PATH"
fi

if [[ "$(uname -m)" == 'i386' ]] && [[ -d "$HOME/.local/bin/i386" ]]; then
  export PATH="$HOME/.local/bin/i386:$PATH"
fi

# ssh
export SSH_ASKPASS=ssh-askpass
export SSH_ASKPASS_REQUIRE='force'

# ssh-agent
eval "$(ssh-agent -s)"
