{ lib, ... }:

let
    name = "keyd";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
