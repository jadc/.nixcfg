{ lib, ... }:

let
    name = "handbrake";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
