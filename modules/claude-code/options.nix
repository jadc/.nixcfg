{ lib, ... }:

let
    name = "claude-code";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
