# Default options that can be defined per profile
# Shared and mutable between nixOS and home-manager

{ lib, ... }:

{
    options.common = {
        profile = lib.mkOption {
            type = lib.types.str;
            description = "The profile of the system";
        };

        arch = lib.mkOption {
            type = lib.types.str;
            default = "x86_64-linux";
            description = "The architecture of the system";
        };

        hostname = lib.mkOption {
            type = lib.types.str;
            description = "The hostname of the system";
        };

        username = lib.mkOption {
            type = lib.types.str;
            description = "The username of the user";
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
