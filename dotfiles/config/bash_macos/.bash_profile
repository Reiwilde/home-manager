#!/usr/bin/env bash

export DOTFILES="$HOME/.dotfiles"
export EDITOR="nvim"

# id
export USER_GID=$(id -g)
export USER_UID=$(id -u)

# xdg
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

# brew
if [[ "$(uname -m)" == "arm64" ]] && [[ -f "/opt/homebrew/bin/brew" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ "$(uname -m)" == "i386" ]] && [[ -f "/usr/local/bin/brew" ]]; then
  export HOMEBREW_NO_ANALYTICS=1
  eval "$(/usr/local/bin/brew shellenv)"
fi

# ssh
OPENSSH_PATH=$(brew --prefix openssh 2>&1)

if [[ $? -eq 0 ]]; then
  export PATH="$OPENSSH_PATH/bin:$OPENSSH_PATH/sbin:$PATH"
fi

# path
if [[ "$(uname -m)" == "arm64" ]] && [[ -d "$HOME/.local/bin/arm64" ]]; then
  export PATH="$HOME/.local/bin/arm64:$PATH"
fi

if [[ "$(uname -m)" == "i386" ]] && [[ -d "$HOME/.local/bin/i386" ]]; then
  export PATH="$HOME/.local/bin/i386:$PATH"
fi

# JetBrains
if [[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]]; then
  export PATH="$PATH:$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
fi
