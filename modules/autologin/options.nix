{ lib, ... }:

let
    name = "autologin";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
