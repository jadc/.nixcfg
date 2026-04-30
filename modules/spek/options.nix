{ lib, ... }:

let
    name = "spek";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
