{ lib, ... }:

let
    name = "fzf";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
