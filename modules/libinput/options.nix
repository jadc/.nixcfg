{ lib, ... }:

let
    name = "libinput";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
