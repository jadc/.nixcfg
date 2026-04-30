{ lib, ... }:

let
    name = "gallery-dl";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
