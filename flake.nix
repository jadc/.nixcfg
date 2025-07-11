{
    description = "jad's nix";

    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: let
        # Given a profile string, creates a NixOS system
        toNixOS = profile: let
            path = ./config/${profile};
            common = ( import (path + "/common.nix") ).config.common;
        in {
            name = common.profile;
            value = nixpkgs.lib.nixosSystem {
                pkgs = import nixpkgs {
                    system = common.arch;
                    config.allowUnfree = true;
                };
                specialArgs.system = common.arch;

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
                            ( import (path + "/common.nix")   )
                            ( import ./config/home.common.nix )
                            ( import (path + "/home.nix")     )
                        ];
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
                };
                extraSpecialArgs = { inherit inputs; };

                modules = [
                    ./config/home/common.nix
                    ./config/home.common.nix
                    ./config/home/home.nix
                ];
            };
        };
    in {
        # NixOS machines
        nixosConfigurations = let
            profiles = [ "main" "laptop" ];
	in
            builtins.listToAttrs (map toNixOS profiles);

        # Non-NixOS machines
        homeConfigurations = let
            systems = [ "x86_64-linux" "aarch64-linux" ];
        in
            builtins.listToAttrs (map toHome systems);

    };
}
