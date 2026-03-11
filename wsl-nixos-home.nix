{
  config,
  pkgs,
  pkgs-unstable,
  repos,
  ...
}:
let
  homeManagerDir = "${config.home.homeDirectory}/Workspaces/home-manager";
  linkDotfile = path: config.lib.file.mkOutOfStoreSymlink "${homeManagerDir}/dotfiles/${path}";
  linkSubmodule = path: config.lib.file.mkOutOfStoreSymlink "${homeManagerDir}/.submodules/${path}";
in {
  home = {
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11"; # Please read the comment before changing.

    homeDirectory = "/home/nixos";
    username = "nixos";

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
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
      #".local/bin/ssh-askpass".source = linkDotfile "local/bin/ssh-askpass-linux";

      # alacritty
      #".config/alacritty/alacritty.toml".source = linkDotfile "config/alacritty/alacritty.toml";
      #".config/alacritty/everforest-dark-hard.toml".source = linkDotfile "config/alacritty/everforest-dark-hard.toml";

      # bash
      ".bash_profile".source = linkDotfile "config/bash/bash_profile";

      # git
      ".config/git/config".source = linkDotfile "config/git_wsl/config";
      ".config/git/gitignore".source = linkDotfile "config/git_wsl/gitignore";

      # nvim
      ".config/nvim".source = linkSubmodule "github.com/reiwilde/nvim";

      # starship
      ".config/starship.toml".source = linkDotfile "config/starship.toml";

      # tmux
      ".config/tmux/tmux.conf".source = linkDotfile "config/tmux/tmux.conf";
      ".config/tmux/plugins/tpm".source = repos.tmux-tpm;

      # zsh
      ".zshenv".source = linkDotfile "config/zsh/zshenv";
      ".config/zsh/.zalias".source = linkDotfile "config/zsh/zalias";
      ".config/zsh/.zlogout".source = linkDotfile "config/zsh/zlogout";
      ".config/zsh/.zprofile".source = linkDotfile "config/zsh/zprofile";
      ".config/zsh/.zshrc".source = linkDotfile "config/zsh/zshrc";
      ".config/zsh/plugins/zsh-history-substring-search".source = repos.zsh-history-substring-search;
      ".config/zsh/plugins/zsh-vi-mode".source = repos.zsh-vi-mode;
    };


    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
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

      gcc
      git
      gnumake
      lsb-release
      luajit
      opencode
      starship
      tmux
      tree

      # payfit{
      #_1password-cli
    ];

    sessionPath = [];

    sessionVariables = {
      EDITOR = "nvim";
      WIN_SYSTEM_DISK = "c";
      WIN_USER = "Reiwilde";
      WIN_HOME = "${config.home.sessionVariables.WIN_SYSTEM_DISK}:/Users/${config.home.sessionVariables.WIN_USER}";
      #SSH_AUTH_SOCK = "$XDG_RUNTIME_DIR/${config.services.ssh-agent.socket}";
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };

  programs = {};

  services = {
    #ssh-agent = {
    #  enable = true;
    #  socket = "ssh-agent";
    #};
  };

  xdg = {
    enable = true;

    #userDirs.enable = true;
  };
}
