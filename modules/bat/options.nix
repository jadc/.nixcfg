{ lib, ... }:

let
    name = "bat";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
