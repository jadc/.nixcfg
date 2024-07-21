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

        nixvim = {
            url = "github:nix-community/nixvim";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-darwin = {
            url = "github:LnL7/nix-darwin";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs: {

        # Main NixOS machine
        nixosConfigurations = let
            profile = "main";
            common = ( import ./config/${profile}/common.nix ).config.common;
        in {
            ${common.hostname} = nixpkgs.lib.nixosSystem {
                modules = [
                    # System-level configuration
                    ./config/${profile}/configuration.nix

                    # User-level configuration
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs; };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${common.username} = import ./config/${profile}/home.nix;
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

        homeConfigurations = {
            # Work: User-level configuration
            work = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./config/work/home.nix
                    inputs.nixvim.homeManagerModules.nixvim
                ];
                #inherit pkgs;
            };
        };

        darwinConfigurations = {
            # Laptop: System-level configuration
            jadc = nix-darwin.lib.darwinSystem {
                modules = [
                    ./config/mac/configuration.nix

                    ./config/home.common.nix
                    ./config/mac/home.nix

                    home-manager.darwinModules.home-manager {
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.jad = ./config/mac/home.nix;
                    }

                    inputs.nixvim.homeManagerModules.nixvim
                ];
            };
        };
    };

}
