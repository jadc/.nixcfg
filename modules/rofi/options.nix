{ lib, ... }:

let
    name = "rofi";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
