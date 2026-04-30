{ lib, ... }:

let
    name = "swapfile";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
