#!/usr/bin/env zsh

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

export EDITOR='nvim'
export NIX_DEV_SHELL="$(which zsh)"

# shell
eval "$(starship init zsh)"

# JetBrains
if [[ -d "$HOME/Library/Application Support/JetBrains/Toolbox/scripts" ]]; then
  export PATH="$HOME/Library/Application Support/JetBrains/Toolbox/scripts:$PATH"
fi

if [[ -d "$ZDOTDIR/plugins/zsh-history-substring-search" ]]; then
  source "$ZDOTDIR/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh"
fi

if [[ -d "$ZDOTDIR/plugins//zsh-vi-mode" ]]; then
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

if [[ -f "$ZDOTDIR/.zalias" ]]; then
  source "$ZDOTDIR/.zalias"
fi
