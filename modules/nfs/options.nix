{ lib, ... }:

let
    name = "nfs";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
