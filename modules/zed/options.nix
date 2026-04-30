{ lib, ... }:

let
    name = "zed";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
        server = lib.mkOption {
            type = lib.types.bool;
            default = true;
        };
    };
}
