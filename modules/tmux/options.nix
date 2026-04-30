{ lib, ... }:

let
    name = "tmux";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
