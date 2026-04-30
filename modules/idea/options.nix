{ lib, ... }:

let
    name = "idea";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
