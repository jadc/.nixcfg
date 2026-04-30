{ lib, ... }:

let
    name = "ripgrep";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
