{ lib, ... }:

let
    name = "samba";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
