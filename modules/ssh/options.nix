{ lib, ... }:

let
    name = "ssh";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
