# Default options that can be defined per profile
# Shared and mutable between nixOS and home-manager

{ lib, ... }:

{
    options = {
        arch = lib.mkOption {
            type = lib.types.string;
            default = "x86_64-linux";
            description = "The architecture of the system";
        };
        hostname = lib.mkOption {
            type = lib.types.string;
            default = "jadc";
            description = "The hostname of the system";
        };
        username = lib.mkOption {
            type = lib.types.string;
            default = "jad";
            description = "The username of the user";
        };

        rootDevice = lib.mkOption {
            type = lib.types.string;
            default = "/dev/vda";
            description = "The root device of the system";
        };
        bootMountPoint = lib.mkOption {
            type = lib.types.string;
            default = "/boot";
            description = "The boot mount point of the system";
        };

        timeZone = lib.mkOption {
            type = lib.types.string;
            default = "America/Edmonton";
            description = "The timezone of the system";
        };

        locale = lib.mkOption {
            type = lib.types.string;
            default = "en_CA.UTF-8";
            description = "The locale of the system";
        };

        aliases = lib.mkOption {
            type = lib.types.attrs;
            default = {};
            description = "The shell aliases of the system";
        };
    }
}
