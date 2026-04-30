{ lib, ... }:

let
    name = "nvidia";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
