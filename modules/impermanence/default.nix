{ inputs, ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            root = {
                dirs = lib.mkOption {
                    type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                    default = [];
                    description = "Directories to persist on the root filesystem.";
                };

                files = lib.mkOption {
                    type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                    default = [];
                    description = "Files to persist on the root filesystem.";
                };
            };

            home = {
                dirs = lib.mkOption {
                    type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                    default = [];
                    description = "Directories to persist in the user's home.";
                };

                files = lib.mkOption {
                    type = lib.types.listOf (lib.types.either lib.types.str lib.types.attrs);
                    default = [];
                    description = "Files to persist in the user's home.";
                };
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        imports = [ inputs.impermanence.nixosModules.impermanence ];

        config = lib.mkIf self.enable {
            cfg.${name}.root = {
                dirs = [
                    "/var/log"
                    "/var/lib/nixos"
                    "/var/lib/systemd"
                    "/etc/nixos"
                ];
                files = [
                    "/etc/machine-id"
                ];
            };

            environment.persistence."/persist" = {
                hideMounts = true;
                directories = lib.unique self.root.dirs;
                files = lib.unique self.root.files;
            };
        };
    };

    flake.modules.homeManager.${name} = { config, options, lib, ... }: let self = config.cfg.${name}; in {
        # Only declare if home.persistence is declared, which impermanence does automatically
        config = lib.optionalAttrs (options ? home.persistence) {
            cfg.${name}.home.dirs = [
                ".nixcfg"
                ".local/share/nvim"
                ".local/state/nvim"
            ];

            home.persistence."/persist" = lib.mkIf self.enable {
                directories = lib.unique self.home.dirs;
                files = lib.unique self.home.files;
            };
        };
    };
}
