# Default options that can be defined per profile
# Shared and mutable between nixOS and home-manager

{ lib, ... }:

{
    options.common = {
        arch = lib.mkOption {
            type = lib.types.str;
            default = "x86_64-linux";
            description = "The architecture of the system";
        };
        hostname = lib.mkOption {
            type = lib.types.str;
            default = "jadc";
            description = "The hostname of the system";
        };
        username = lib.mkOption {
            type = lib.types.str;
            default = "jad";
            description = "The username of the user";
        };

        rootDevice = lib.mkOption {
            type = lib.types.str;
            default = "/dev/sda";
            description = "The root device of the system";
        };
        bootMountPoint = lib.mkOption {
            type = lib.types.str;
            default = "/boot";
            description = "The boot mount point of the system";
        };

        timeZone = lib.mkOption {
            type = lib.types.str;
            default = "America/Edmonton";
            description = "The timezone of the system";
        };

        locale = lib.mkOption {
            type = lib.types.str;
            default = "en_CA.UTF-8";
            description = "The locale of the system";
        };

        aliases = lib.mkOption {
            type = lib.types.attrs;
            default = {};
            description = "The shell aliases of the system";
        };
    };
}
