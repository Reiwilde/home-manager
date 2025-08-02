#!/usr/bin/env zsh
#
# nix
export NIX_DEV_SHELL="$(which zsh)"

if [[ $LSB_RELEASE_ID == 'Fedora' ]] && [[ -f "$HOME/.nix-profile/etc/profile.d/nix.sh" ]]; then 
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

HISTFILE="$ZDOTDIR/.zsh_history"
HISTSIZE=999999999

SAVEHIST=$HISTSIZE

setopt SHARE_HISTORY

# auto completion
autoload -Uz compinit && compinit

# secrets
if [[ -f "$ZDOTDIR/.secrets" ]]; then
  source "$ZDOTDIR/.secrets"
fi

# docker
export DOCKER_SOCK="$XDG_RUNTIME_DIR/docker.sock"

# aws sam
export SAM_CLI_TELEMETRY=0

# cargo
export CARGO_HOME="$USER_APPS_HOME/cargo"
export RUSTUP_HOME="$USER_APPS_HOME/rustup"

if [[ -f "$CARGO_HOME/env" ]]; then
  source $CARGO_HOME/env
fi

# local/bin
if [[ -d "$HOME/.local/bin" ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# shell
eval "$(starship init zsh)"

if [[ -d "$ZDOTDIR/plugins/zsh-history-substring-search" ]]; then
  source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

if [[ -d "$ZDOTDIR/plugins/zsh-vi-mode" ]]; then
  function zvm_config() {
    ZVM_LAZY_KEYBINDINGS=false
  }

  function zvm_set_keys() {
    zvm_bindkey viins '^[[A' history-substring-search-up
    zvm_bindkey viins '^[[B' history-substring-search-down
    zvm_bindkey viins '^N' history-substring-search-down
    zvm_bindkey viins '^P' history-substring-search-up
  }

  zvm_after_init_commands=('zvm_set_keys')

  source "$ZDOTDIR/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh"
fi

# alias
if [[ -f "$ZDOTDIR/.zalias" ]]; then
  source "$ZDOTDIR/.zalias"
fi
