{ lib, ... }:

let
    name = "gdb";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
