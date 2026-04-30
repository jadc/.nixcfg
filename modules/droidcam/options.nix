{ lib, ... }:

let
    name = "droidcam";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
