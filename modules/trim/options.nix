{ lib, ... }:

let
    name = "trim";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
