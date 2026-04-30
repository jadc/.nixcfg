{ lib, ... }:

let
    name = "avidemux";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
