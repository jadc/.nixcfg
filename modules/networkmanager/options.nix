{ lib, ... }:

let
    name = "networkmanager";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
