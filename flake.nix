{
    inputs = {
        nixpkgs = {
            url = "github:NixOS/nixpkgs/nixos-unstable";
        };

        home-manager = {
            url = "github:nix-community/home-manager";
            inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, home-manager, ... } @ inputs: let
        # Given a profile string, creates a NixOS system
        toNixOS = profile: let
            path = ./profiles/${profile};
            const = ( import (path + "/const.nix") ).cfg.const;
        in {
            name = const.profile;
            value = nixpkgs.lib.nixosSystem {
                pkgs = import nixpkgs {
                    system = const.arch;
                    config.allowUnfree = true;
                    config.permittedInsecurePackages = [ "qtwebengine-5.15.19" ];
                };
                specialArgs.system = const.arch;

                modules = [
                    ./cfg/const
                    ./cfg/system
                    (path + "/hardware-configuration.nix")
                    (path + "/configuration.nix")

                    # User-level configuration
                    home-manager.nixosModules.home-manager {
                        home-manager.extraSpecialArgs = { inherit inputs; };
                        home-manager.useGlobalPkgs = true;
                        home-manager.useUserPackages = true;
                        home-manager.users.${const.username} = nixpkgs.lib.mkMerge [
                            ( import ./cfg/const )
                            ( import ./cfg/user )
                            ( import (path + "/home.nix") )
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
                    ./cfg/const
                    ./cfg/user
                    ./profiles/home/home.nix
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
