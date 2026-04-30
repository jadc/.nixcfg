{ lib, ... }:

let
    name = "sunshine";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
