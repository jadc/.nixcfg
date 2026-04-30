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
    };

    outputs = { self, nixpkgs, home-manager, nvim, ... } @ inputs: let
        username = "jad";

        # Given a profile string, creates a NixOS system with it as hostname
        toNixOS = name: let
            profile = ./profiles/${name};
        in {
            inherit name;
            value = nixpkgs.lib.nixosSystem {
                specialArgs = { inherit inputs username; };
                modules = [
                    { networking.hostName = name; }
                    ./modules
                    (profile + "/hardware-configuration.nix")
                    (profile + "/profile.nix")

                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs username; };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.sharedModules = [
                            ./modules/home.nix
                            nvim.homeManagerModules.default
                        ];
                        home-manager.users.${username} = import (profile + "/profile.nix");
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
                extraSpecialArgs = { inherit inputs username; };

                modules = [
                    ./modules/home.nix
                    ./profiles/home/profile.nix
                    nvim.homeManagerModules.default
                ];
            };
        };
    in {
        # NixOS machines
        nixosConfigurations = let
            profiles = [ "jad-desktop" "jad-laptop" ];
        in builtins.listToAttrs (map toNixOS profiles);

        # Non-NixOS machines
        homeConfigurations = let
            systems = [ "x86_64-linux" "aarch64-linux" ];
        in builtins.listToAttrs (map toHome systems);
    };
}
