{ lib, ... }:

let
    name = "ffmpeg";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
