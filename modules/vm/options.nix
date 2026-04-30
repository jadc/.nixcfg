{ lib, ... }:

let
    name = "vm";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
