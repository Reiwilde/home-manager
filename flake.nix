{
  description = "Home Manager configuration of reiwilde";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tmux-tpm = {
      flake = false;
      url = "github:tmux-plugins/tpm";
    };

    zsh-history-substring-search = {
      flake = false;
      url = "github:zsh-users/zsh-history-substring-search";
    };

    zsh-vi-mode = {
      flake = false;
      url = "github:jeffreytse/zsh-vi-mode";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, ... } @ args: 
    let
      repos = {
        inherit (args) tmux-tpm zsh-history-substring-search zsh-vi-mode;
      };
    in {
      homeConfigurations = {
        fedora-vm = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."x86_64-linux";

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./fedora-vm-home.nix
            {
              _module.args = {
                inherit repos;
              };
            }
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };

        payfit-mac = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages."aarch64-darwin";

          # Specify your home configuration modules here, for example,
          # the path to your home.nix.
          modules = [
            ./payfit-mac-home.nix
            {
              _module.args = {
                inherit repos;
              };
            }
          ];

          # Optionally use extraSpecialArgs
          # to pass through arguments to home.nix
        };
      };
    };
}
