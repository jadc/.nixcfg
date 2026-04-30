{ lib, ... }:

let
    name = "sound";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
