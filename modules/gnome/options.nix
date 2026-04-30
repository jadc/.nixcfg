{ lib, ... }:

let
    name = "gnome";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;

        monitors = lib.mkOption {
            type = lib.types.nullOr lib.types.path;
            default = null;
            description = "Path to monitors.xml file for GNOME display configuration";
        };
    };
}
