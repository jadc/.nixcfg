{ inputs, ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            path = lib.mkOption {
                type = lib.types.str;
                default = "/static";
            };

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

    flake.modules.nixos.${name} = { config, lib, username, ... }: let self = config.cfg.${name}; in {
        imports = [ inputs.preservation.nixosModules.preservation ];

        config = lib.mkIf self.enable {
            # Default files and directories to persist
            cfg.${name} = {
                root = {
                    dirs = [
                        "/var/log"
                        "/var/lib/nixos"
                        "/var/lib/systemd"
                        "/etc/nixos"
                    ];
                    files = [
                        { file = "/etc/machine-id"; inInitrd = true; }
                    ];
                };
                home.dirs = [
                    ".nixcfg"
                ];
            };

            # machine-id is already bind-mounted from persistent storage
            systemd.services.systemd-machine-id-commit.enable = false;

            preservation = {
                enable = true;
                preserveAt.${self.path} = {
                    commonMountOptions = [ "x-gvfs-hide" ];

                    directories = lib.unique self.root.dirs;
                    files = lib.unique self.root.files;

                    users.${username} = let
                        hmCfg = config.home-manager.users.${username}.cfg.${name};
                    in {
                        directories = lib.unique hmCfg.home.dirs;
                        files = lib.unique hmCfg.home.files;
                    };
                };
            };
        };
    };
}
