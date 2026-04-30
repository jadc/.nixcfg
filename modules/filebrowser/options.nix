{ lib, ... }:

let
    name = "filebrowser";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
