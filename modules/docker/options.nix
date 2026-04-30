{ lib, ... }:

let
    name = "docker";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
