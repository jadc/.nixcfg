{ lib, ... }:

let
    name = "rnote";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
