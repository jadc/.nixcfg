{ lib, ... }:

let
    name = "puddletag";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
