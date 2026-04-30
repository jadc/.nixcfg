{ lib, ... }:

let
    name = "zoxide";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
