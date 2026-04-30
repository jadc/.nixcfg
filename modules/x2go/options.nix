{ lib, ... }:

let
    name = "x2go";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
