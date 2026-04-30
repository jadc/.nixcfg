{ lib, ... }:

let
    name = "wireguard";
in
{
    options.cfg.${name} = {
        enable = lib.mkEnableOption name;

        configurations = lib.mkOption {
            type = lib.types.attrsOf lib.types.path;
            default = {};
            description = "WireGuard configurations to manage (name -> config file path)";
        };
    };
}
