{ lib, ... }:

let
    name = "yt";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
