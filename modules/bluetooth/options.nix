{ lib, ... }:

let
    name = "bluetooth";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
