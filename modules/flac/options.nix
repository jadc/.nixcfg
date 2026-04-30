{ lib, ... }:

let
    name = "flac";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
