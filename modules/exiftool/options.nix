{ lib, ... }:

let
    name = "exiftool";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
