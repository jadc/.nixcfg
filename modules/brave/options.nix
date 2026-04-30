{ lib, ... }:

let
    name = "brave";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
