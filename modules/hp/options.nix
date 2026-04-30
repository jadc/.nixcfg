{ lib, ... }:

let
    name = "hp";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption "HP-specific drivers and firmware";
    };
}
