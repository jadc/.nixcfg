{ lib, ... }:

let
    name = "spotifyify";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
