{

    description = "jad's nixos";

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
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs:
        let
            x86 = "x86_64-linux";

            pkgs = import nixpkgs {
                system = x86;
                config.allowUnfree = true;
            };
        in {

        # System configuration
        nixosConfigurations = {
            jadc = nixpkgs.lib.nixosSystem {
                specialArgs.system = x86;
                modules = [
                    ./config/configuration.common.nix
                    ./config/main/common.nix
                    ./config/main/configuration.nix
                ];
                inherit pkgs;
            };
        };

        # User(s) configuration
        homeConfigurations = {
            jad = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./config/home.common.nix
                    ./config/main/common.nix
                    ./config/main/home.nix
                    inputs.nixvim.homeManagerModules.nixvim
                ];
                inherit pkgs;
            };

            work = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./config/home.common.nix
                    ./config/work/common.nix
                    ./config/work/home.nix
                    inputs.nixvim.homeManagerModules.nixvim
                ];
                inherit pkgs;
            };
        };

    };

}
