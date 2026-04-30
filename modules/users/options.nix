{ lib, ... }:

let
    name = "users";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
