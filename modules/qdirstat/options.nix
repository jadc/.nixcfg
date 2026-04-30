{ lib, ... }:

let
    name = "qdirstat";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
