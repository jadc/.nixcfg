{ lib, ... }:

let
    name = "hyperfine";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
