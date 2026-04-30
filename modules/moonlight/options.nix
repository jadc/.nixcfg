{ lib, ... }:

let
    name = "moonlight";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
