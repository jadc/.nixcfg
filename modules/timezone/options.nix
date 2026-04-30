{ lib, ... }:

let
    name = "timezone";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
