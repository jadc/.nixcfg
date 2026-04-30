{ lib, ... }:

let
    name = "htop";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
