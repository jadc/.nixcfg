{ lib, ... }:

let
    name = "spotify";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
