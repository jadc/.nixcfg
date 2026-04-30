{ lib, ... }:

let
    name = "automount";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
