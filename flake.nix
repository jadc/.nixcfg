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

    outputs = { self, nixpkgs, home-manager, nix-darwin, ... }@inputs:
        let
            x86 = "x86_64-linux";

            pkgs = import nixpkgs {
                system = x86;
                config.allowUnfree = true;
            };
        in {

        nixosConfigurations = {
            # Main: System-level configuration
            jadc = nixpkgs.lib.nixosSystem {
                specialArgs.system = x86;
                modules = [
                    ./config/main/configuration.nix
                ];
                inherit pkgs;
            };
        };

        homeConfigurations = {
            # Main: User-level configuration
            jad = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./config/main/home.nix
                    inputs.nixvim.homeManagerModules.nixvim
                ];
                inherit pkgs;
            };

            # Work: User-level configuration
            work = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./config/work/home.nix
                    inputs.nixvim.homeManagerModules.nixvim
                ];
                inherit pkgs;
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
