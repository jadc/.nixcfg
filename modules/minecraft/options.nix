{ lib, ... }:

let
    name = "minecraft";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
