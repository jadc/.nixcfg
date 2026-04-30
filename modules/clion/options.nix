{ lib, ... }:

let
    name = "clion";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
