{ lib, ... }:

let
    name = "maim";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
