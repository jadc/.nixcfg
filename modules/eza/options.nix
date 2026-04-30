{ lib, ... }:

let
    name = "eza";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
