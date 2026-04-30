{ lib, ... }:

let
    name = "inkscape";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
