{ lib, ... }:

let
    name = "envs";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
