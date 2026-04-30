{ lib, ... }:

let
    name = "git";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
