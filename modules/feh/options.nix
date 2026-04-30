{ lib, ... }:

let
    name = "feh";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
