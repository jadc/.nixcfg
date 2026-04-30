{ lib, pkgs, ... }:

let
    name = "kernel";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;

        build = lib.mkOption {
            type = lib.types.raw;
            default = pkgs.linuxPackages_latest;
        };

        flags = {
            quiet = lib.mkOption {
                type = lib.types.bool;
                default = false;
            };

            performance = lib.mkOption {
                type = lib.types.bool;
                default = false;
            };

            vfio = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [];
                description = "Enable VFIO kernel modules and specify PCI device IDs to passthrough";
            };

            intel = lib.mkOption {
                type = lib.types.bool;
                default = false;
            };

            nvidia = lib.mkOption {
                type = lib.types.bool;
                default = false;
            };
        };
    };
}
