{ lib, ... }:

let
    name = "gimp";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
