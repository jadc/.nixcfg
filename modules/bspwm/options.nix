{ lib, ... }:

let
    name = "bspwm";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;

        monitors = {
            primary = lib.mkOption {
                type = lib.types.str;
                default = "";
            };
            secondary = lib.mkOption {
                type = lib.types.str;
                default = "";
            };
        };
    };
}
