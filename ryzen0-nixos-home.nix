{ config, hyprland, pkgs, repos, ... }:
let
  homeManagerDir = "${config.home.homeDirectory}/Workspaces/home-manager";
  linkDotfile = path: config.lib.file.mkOutOfStoreSymlink "${homeManagerDir}/dotfiles/${path}";
  linkSubmodule = path: config.lib.file.mkOutOfStoreSymlink "${homeManagerDir}/.submodules/${path}";
in {
  home = {
    # Home Manager needs a bit of information about you and the paths it should
    # manage.
    username = "reiwilde";
    homeDirectory = "/home/reiwilde";

    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "25.11"; # Please read the comment before changing.

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

      alacritty
      gcc
      git
      gnumake
      lsb-release
      luajit
      nerd-fonts.jetbrains-mono
      pinentry-qt
      starship
      tmux
      uwsm
    ];

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
      #".config/hypr/hyprland.conf".source = linkDotfile "config/hypr/hyprland.conf";

      # nix
      #".config/nix/nix.conf".source = linkDotfile "config/nix/nix.conf";

      # nvim
      ".config/nvim".source = linkSubmodule "github.com/reiwilde/nvim";

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

    sessionPath = [];

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
    sessionVariables = {
      # EDITOR = "emacs";
    };
  };

  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;

  # Install fonts
  fonts.fontconfig.enable = true;

  wayland = {
    windowManager.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

      systemd.enable = false;
      xwayland.enable = true;

      settings = {
        # See https://wiki.hypr.land/Configuring/Keywords/
        "$mainMod" = "SUPER";
        "$mainMonitor" = "DP-3";
        "$secondMoniror" = "HDMI-A-2";

        "$browser" = "io.gitlab.librewolf-community.desktop";
        "$terminal" = "alacritty";

        # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
        bind = [
          "$mainMod, B, exec, uwsm app -- $browser"
          #"$mainMod, E, exec, uwsm app -- $fileManager"
          "$mainMod, P, pseudo, # dwindle"
          "$mainMod, Q, killactive"
          #"$mainMod, R, exec, uwsm app -- $menu"
          "$mainMod, T, exec, uwsm app -- $terminal"
          "$mainMod, V, togglefloating"

          # Exit hyprland
          "$mainMod SHIFT, E, exec, uwsm stop"

          # Move focus with mainMod + arrow keys
          "$mainMod, H, layoutmsg, focus l"
          "$mainMod, L, layoutmsg, focus r"
          "$mainMod, K, layoutmsg, focus u"
          "$mainMod, J, layoutmsg, focus d"

          # Resize window
          "$mainMod, M, layoutmsg, colresize +conf"
          "$mainMod SHIFT, M, layoutmsg, colresize -conf"

          # Switch workspaces with mainMod + [0-9]
          "$mainMod, 1, workspace, 1"
          "$mainMod, 2, workspace, 2"
          "$mainMod, 3, workspace, 3"
          "$mainMod, 4, workspace, 4"
          "$mainMod, 5, workspace, 5"
          "$mainMod, 6, workspace, 6"
          "$mainMod, 7, workspace, 7"
          "$mainMod, 8, workspace, 8"
          "$mainMod, 9, workspace, 9"
          "$mainMod, 0, workspace, 10"

          # Move active window to a workspace with mainMod + SHIFT + [0-9]
          "$mainMod SHIFT, 1, movetoworkspace, 1"
          "$mainMod SHIFT, 2, movetoworkspace, 2"
          "$mainMod SHIFT, 3, movetoworkspace, 3"
          "$mainMod SHIFT, 4, movetoworkspace, 4"
          "$mainMod SHIFT, 5, movetoworkspace, 5"
          "$mainMod SHIFT, 6, movetoworkspace, 6"
          "$mainMod SHIFT, 7, movetoworkspace, 7"
          "$mainMod SHIFT, 8, movetoworkspace, 8"
          "$mainMod SHIFT, 9, movetoworkspace, 9"
          "$mainMod SHIFT, 0, movetoworkspace, 10"

          # Example special workspace (scratchpad)
          "$mainMod, S, togglespecialworkspace, magic"
          "$mainMod SHIFT, S, movetoworkspace, special:magic"

          # Scroll through existing workspaces with mainMod + scroll
          "$mainMod, mouse_down, workspace, e+1"
          "$mainMod, mouse_up, workspace, e-1"
        ];

        bindel = [
          # Laptop multimedia keys for volume and LCD brightness
          ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
          ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
          ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
          ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
          ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
          ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
        ];

        bindl = [
          # Requires playerctl
          ",XF86AudioNext, exec, playerctl next"
          ",XF86AudioPause, exec, playerctl play-pause"
          ",XF86AudioPlay, exec, playerctl play-pause"
          ",XF86AudioPrev, exec, playerctl previous"
        ];

        bindm = [
          # Move/resize windows with mainMod + LMB/RMB and dragging
          "$mainMod, mouse:272, movewindow"
          "$mainMod, mouse:273, resizewindow"
        ];


        animations = {
          enabled = "yes, please :)";

          # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
          #        NAME,           X0,   Y0,   X1,   Y1
          bezier = [ 
            "easeOutQuint,   0.23, 1,    0.32, 1"
            "easeInOutCubic, 0.65, 0.05, 0.36, 1"
            "linear,         0,    0,    1,    1"
            "almostLinear,   0.5,  0.5,  0.75, 1"
            "quick,          0.15, 0,    0.1,  1"
          ];

          # Default animations, see https://wiki.hypr.land/Configuring/Animations/
          #            NAME,   ONOFF, SPEED, CURVE, [STYLE]
          animation = "global, 1,     1,     default";
        };

        decoration = {
          # Change transparency of focused and unfocused windows
          active_opacity = 1.0;
          inactive_opacity = 1.0;

          rounding = 6;
          rounding_power = 2;

          # https://wiki.hyprland.org/Configuring/Variables/#blur
          blur = {
            enabled = true;
            passes = 1;
            size = 3;
            vibrancy = 0.1696;
          };

          shadow = {
            enabled = true;
            color = "rgba(1a1a1aee)";
            range = 4;
            render_power = 3;
          };
        };

        # Example per-device config
        # See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
        device = {
          name = "epic-mouse-v1";
          sensitivity = -0.5;
        };

        dwindle = {
          # You probably want this
          preserve_split = true; 
          # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
          pseudotile = true;
        };

        general = {
          # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          border_size = 2;

          gaps_in = 4;
          gaps_out = 8;

          # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";

          layout = "scrolling";

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = false;
        };

        # https://wiki.hyprland.org/Configuring/Variables/#input
        input = {
          follow_mouse = 1;

          kb_layout = "us";
          kb_model = "";
          kb_options = "";
          kb_rules = "";
          kb_variant = "intl";

          # -1.0 - 1.0, 0 means no modification.
          sensitivity = 0; 

          touchpad = {
            natural_scroll = false;
          };
        };

        # See https://wiki.hypr.land/Configuring/Gestures
        gesture = [
          "3, horizontal, workspace"
        ];

        # https://wiki.hyprland.org/Configuring/Variables/#misc
        misc = {
          # If true disables the random hyprland logo / anime girl background. :(
          disable_hyprland_logo = false; 
          # Set to 0 or 1 to disable the anime mascot wallpapers
          force_default_wallpaper = -1; 
        };

        monitorv2 = [
          {
            output = "$mainMonitor";
            bitdepth = 10;
            #cm = "hdr";
            mode = "2560x1440@165";
            position = "0x0";
            scale = 1;
            sdrbrightness = 1.0;
            sdrsaturation = 1.0;
          }
          {
            output = "$secondMoniror";
            mode = "1920x1080@60";
            position = "2560x360";
            scale = 1;
          }
        ];

        scrolling = {
          direction = "right";
          column_width = 0.667;
          explicit_column_widths = "0.333, 0.5, 0.667, 1.0";
          focus_fit_method = 0;
          follow_focus = true;
          follow_min_visible = 0.4;
          fullscreen_on_one_column = false;
        };


        # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
        # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules
        windowrule = [
          {
            # Ignore maximize requests from all apps. You'll probably like this.
            name = "suppress-maximize-events";
            suppress_event = "maximize";

            "match:class" = ".*";
          }
          {
            # Fix some dragging issues with XWayland
            name = "fix-xwayland-drags";
            no_focus = true;

            "match:class" = "^$";
            "match:title" = "^$";
            "match:xwayland" = true;
            "match:float" = true;
            "match:fullscreen" = false;
            "match:pin" = false;
          }
          # Hyprland-run windowrule
          {
            float = "yes";
            move = "20 monitor_h-120";
            name = "move-hyprland-run";

            "match:class" = "hyprland-run";
          }
        ];

        workspace = [
          "1, monitor:$mainMonitor, default:true"
          "2, monitor:$secondMoniror, default:true"
          "3, monitor:$mainMonitor"
          "4, monitor:$secondMoniror"
          "5, monitor:$mainMonitor"
          "6, monitor:$secondMoniror"
          "7, monitor:$mainMonitor"
          "8, monitor:$secondMoniror"
          "9, monitor:$mainMonitor"
          "10, monitor:$secondMoniror"
        ];
      };

      extraConfig = ''
      '';
    };
  };
}
