{ lib, ... }:

let
    name = "rgb";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
        off = lib.mkOption {
            type = lib.types.bool;
            default = false;
            description = "Disable all RGB lighting";
        };
    };
}
