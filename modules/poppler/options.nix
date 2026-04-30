{ lib, ... }:

let
    name = "poppler";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
