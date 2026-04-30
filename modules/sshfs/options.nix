{ lib, ... }:

let
    name = "sshfs";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;
    };
}
