{
    description = "jad's nix";

    inputs = {
        nixpkgs = {
            url = "nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        profiles = [ "main" "laptop" ];

        # Given a profile string, creates a NixOS system
        toNixOS = profile: let
            path = ./config/${profile};
            common = ( import (path + "/common.nix") ).config.common;
        in {
            name = common.profile;
            value = nixpkgs.lib.nixosSystem {
                modules = [
                    # System-level configuration
                    { networking.hostName = "jadc"; }
                    (path + "/common.nix")
                    ./config/configuration.common.nix
                    (path + "/hardware-configuration.nix")
                    (path + "/configuration.nix")

                    # User-level configuration
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs; };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${common.username} = nixpkgs.lib.mkMerge [
                            ( import (path + "/common.nix") )
                            ( import ./config/home.common.nix )
                            ( import (path + "/home.nix") )
                        ];
                    }
                ];

                # Use correct architecture
                pkgs = import nixpkgs {
                    system = common.arch;
                    config.allowUnfree = true;
                };
                specialArgs.system = common.arch;
            };
        };
    in {
        # NixOS machines
        nixosConfigurations = builtins.listToAttrs (map toNixOS profiles);

        # Non-NixOS machines
        homeConfigurations = let
            common = ( import ./config/home/common.nix ).config.common;
        in {
            ${common.profile} = home-manager.lib.homeManagerConfiguration {
                modules = [
										./config/home.common.nix
										./config/${common.profile}/common.nix
										./config/${common.profile}/home.nix
								];
								extraSpecialArgs = { inherit inputs; };

                # Use correct architecture
                pkgs = import nixpkgs {
                    system = common.arch;
                    config.allowUnfree = true;
                };
            };
        };

    };
}
