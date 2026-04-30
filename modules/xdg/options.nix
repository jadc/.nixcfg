{ lib, ... }:

let
    name = "xdg";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
