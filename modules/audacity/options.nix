{ lib, ... }:

let
    name = "audacity";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
