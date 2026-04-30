{ lib, ... }:

let
    name = "moshserver";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
