{ lib, ... }:

let
    name = "virtualbox";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
