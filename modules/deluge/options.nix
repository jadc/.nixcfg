{ lib, ... }:

let
    name = "deluge";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
