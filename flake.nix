{
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nvim.url = "github:jadc/nvim";
        neovim-nightly-overlay = {
            url = "github:nix-community/neovim-nightly-overlay";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nvim, ... } @ inputs: let
        # Given a profile string, creates a NixOS system
        toNixOS = name: let
            profile = ./profiles/${name};
            const = ( import (profile + "/const.nix") ).cfg.const;
        in {
            name = const.profile;
            value = nixpkgs.lib.nixosSystem {
                pkgs = import nixpkgs {
                    system = const.arch;
                    config.allowUnfree = true;
                    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
                };
                specialArgs.system = const.arch;

                modules = [
                    (profile + "/hardware-configuration.nix")

                    ./cfg/const
                    (profile + "/const.nix")
                    ./cfg/modules
                    (profile + "/configuration.nix")

                    # User-level configuration
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs; };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.sharedModules = [
                            ./cfg/const
                            (profile + "/const.nix")
                            nvim.homeManagerModules.default
                        ];
                        home-manager.users.${const.username} = import (profile + "/home.nix");
                    }
                ];
            };
        };

        toHome = system: {
            name = "home-${system}";
            value = home-manager.lib.homeManagerConfiguration {
                pkgs = import nixpkgs {
                    inherit system;
                    config.allowUnfree = true;
                    overlays = [ inputs.neovim-nightly-overlay.overlays.default ];
                };
                extraSpecialArgs = { inherit inputs; };

                modules = [
                    ./cfg/const
                    ./profiles/home/const.nix
                    ./cfg/modules/home.nix
                    ./profiles/home/home.nix
                    nvim.homeManagerModules.default
                ];
            };
        };
    in {
        # NixOS machines
        nixosConfigurations = let
            profiles = [ "main" "laptop" ];
        in builtins.listToAttrs (map toNixOS profiles);

        # Non-NixOS machines
        homeConfigurations = let
            systems = [ "x86_64-linux" "aarch64-linux" ];
        in builtins.listToAttrs (map toHome systems);
    };
}
