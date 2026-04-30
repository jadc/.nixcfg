{ lib, ... }:

let
    name = "direnv";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
