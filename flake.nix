{

    description = "NixOS";

    inputs = {
        nixpkgs = {
            url = "nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... }: 
        let
            system = "x86_64-linux";

            pkgs = import nixpkgs {
                inherit system;

                config = {
                    allowUnfree = true;
                };
            };
        in {

        # System configuration
        nixosConfigurations = {
            jadc = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit system; };
                modules = [ ./nixos/configuration.nix ];
            };
        };

        # User(s) configuration
        homeConfigurations = {
            jad = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                modules = [ ./home.nix ];
            };
        };

    };

}
