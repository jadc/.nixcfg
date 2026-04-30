{ lib, ... }:

let
    name = "moshclient";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
