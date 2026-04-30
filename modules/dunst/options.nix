{ lib, ... }:

let
    name = "notifications";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
