{ lib, ... }:

let
    name = "mpv";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
