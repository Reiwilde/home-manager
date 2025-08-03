#!/usr/bin/env bash

export DOTFILES="$HOME/.dotfiles"
export EDITOR='nvim'

# id
export USER_GID="$(id -g)"
export USER_UID="$(id -u)"

# release
export LSB_RELEASE_ID="$(lsb_release -si)"

# xdg
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export USER_APPS_HOME="$HOME/.local/apps"

# asdf
export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

if [[ -z $IN_NIX_SHELL ]] && [[ -d "$ASDF_DATA_DIR/shims" ]]; then
  export PATH="$ASDF_DATA_DIR/shims:$PATH"
fi

# path
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [[ -f "$USER_APPS_HOME/cargo/env" ]]; then
  source "$USER_APPS_HOME/cargo/env"
fi

if [[ $LSB_RELEASE_ID == 'Fedora' ]] && [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then 
  source $HOME/.nix-profile/etc/profile.d/nix.sh
fi

if [[ -f "$HOME/.bashrc" ]]; then
  source $HOME/.bashrc
fi
