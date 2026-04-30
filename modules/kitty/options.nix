{ lib, ... }:

let
    name = "kitty";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
        fontSize = lib.mkOption {
            type = lib.types.int;
            default = 12;
        };
    };
}
