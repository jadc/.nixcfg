{ lib, ... }:

let
    name = "virt-manager";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
