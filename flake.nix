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
            profile = ( import ./profile.nix ).profile;
            common = ( import ./profiles/${profile}/common.nix );

            system = common.arch;
            pkgs = import nixpkgs {
                inherit system;
                config.allowUnfree = true;
            };
        in {

        # System configuration
        nixosConfigurations = {
            ${common.hostname} = nixpkgs.lib.nixosSystem {
                modules = [ ./profiles/${profile}/configuration.nix ];
                specialArgs = { inherit system; inherit common; };
            };
        };

        # User(s) configuration
        homeConfigurations = {
            ${common.username} = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [
                    ./profiles/${profile}/home.nix
                    inputs.nixvim.homeManagerModules.nixvim
                ];
                extraSpecialArgs = { inherit common; };
            };
        };

    };

}
