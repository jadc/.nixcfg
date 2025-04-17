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

    outputs = { self, nixpkgs, home-manager, ... }@inputs: {

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

        # Non-NixOS machines
        homeConfigurations = let
            profile = "work";
            common = ( import ./config/${profile}/common.nix ).config.common;
        in {
            ${common.hostname} = home-manager.lib.homeManagerConfiguration {
                modules = [
                    ./config/${profile}/home.nix
                ];
                extraSpecialArgs = { inherit inputs; };  # Required for Nixvim

                # Use correct architecture
                pkgs = import nixpkgs {
                    system = common.arch;
                    config.allowUnfree = true;
                };
            };
        };

    };
}
