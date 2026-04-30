{ lib, ... }:

let
    name = "steam";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
