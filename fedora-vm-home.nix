{ config, pkgs, repos, ... }:
let
  linkDotfile = path: config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.config/home-manager/dotfiles/${path}";
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "reiwilde";
  home.homeDirectory = "/home/reiwilde";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

    pkgs.btop
    pkgs.git
    pkgs.git-lfs
    pkgs.gcc
    pkgs.gnumake
    pkgs.luajit
    pkgs.neovim
    pkgs.nerd-fonts.jetbrains-mono
    pkgs.starship
    pkgs.tmux
    pkgs.wl-clipboard
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfile/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';

    # .local/bin
    ".local/bin/opencode".source = dotfiles/local/bin/opencode-v0.3.78-linux-amd64;
    ".local/bin/ssh-askpass".source = linkDotfile "local/bin/ssh-askpass-linux";

    # alacritty
    ".config/alacritty/alacritty.toml".source = linkDotfile "config/alacritty/alacritty.toml";
    ".config/alacritty/everforest-dark-hard.toml".source = linkDotfile "config/alacritty/everforest-dark-hard.toml";

    # bash
    ".bash_profile".source = linkDotfile "config/bash/bash_profile";

    # git
    ".config/git/config".source = linkDotfile "config/git/config";
    ".config/git/gitignore".source = linkDotfile "config/git/gitignore";

    # hypr
    ".config/hypr/hyprland.conf".source = linkDotfile "config/hypr/hyprland.conf";

    # nix
    ".config/nix/nix.conf".source = linkDotfile "config/nix/nix.conf";

    # starship
    ".config/starship.toml".source = linkDotfile "config/starship.toml";

    # tmux
    ".config/tmux/tmux.conf".source = linkDotfile "config/tmux/tmux.conf";
    ".config/tmux/plugins/tpm".source = repos.tmux-tpm;

    # uwsm
    ".config/uwsm/env-hyprland".source = linkDotfile "config/uwsm/env-hyprland";

    # xdg-desktop-portal
    ".config/xdg-desktop-portal/hyprland-portals.conf".source = linkDotfile "config/xdg-desktop-portal/hyprland-portals.conf";

    # zsh
    ".zshenv".source = linkDotfile "config/zsh/zshenv";
    ".config/zsh/.zalias".source = linkDotfile "config/zsh/zalias";
    ".config/zsh/.zlogout".source = linkDotfile "config/zsh/zlogout";
    ".config/zsh/.zprofile".source = linkDotfile "config/zsh/zprofile";
    ".config/zsh/.zshrc".source = linkDotfile "config/zsh/zshrc";
    ".config/zsh/plugins/zsh-history-substring-search".source = repos.zsh-history-substring-search;
    ".config/zsh/plugins/zsh-vi-mode".source = repos.zsh-vi-mode;
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/reiwilde/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Install fonts
  fonts.fontconfig.enable = true;
}
