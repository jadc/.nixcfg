{ lib, ... }:

let
    name = "qt";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
