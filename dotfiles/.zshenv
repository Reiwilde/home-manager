#!/usr/bin/env zsh

# id
export USER_GID="$(id -g)"
export USER_UID="$(id -u)"

# release
export LSB_RELEASE_ID="$(lsb_release -si)"

export DOTFILES="$HOME/.dotfiles"
export EDITOR='nvim'

# xdg
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

export USER_APPS_HOME="$HOME/.local/apps"

# zsh
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
