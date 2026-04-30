{ lib, ... }:

let
    name = "archivers";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
