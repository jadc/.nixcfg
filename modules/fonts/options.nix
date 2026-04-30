{ lib, ... }:

let
    name = "fonts";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
