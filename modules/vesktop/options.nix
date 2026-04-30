{ lib, ... }:

let
    name = "vesktop";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
