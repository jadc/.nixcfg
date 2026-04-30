{ lib, ... }:

let
    name = "syncthing";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
