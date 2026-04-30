{ lib, ... }:

let
    name = "rsync";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
