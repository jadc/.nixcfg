{ lib, ... }:

let
    name = "obsidian";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
