{ lib, ... }:

let
    name = "zathura";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
