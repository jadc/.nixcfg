{ lib, ... }:

let
    name = "jellyfin-player";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
