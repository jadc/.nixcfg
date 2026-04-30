{ lib, ... }:

let
    name = "parallel-launcher";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
