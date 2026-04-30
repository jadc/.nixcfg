{ lib, ... }:

let
    name = "obs";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
