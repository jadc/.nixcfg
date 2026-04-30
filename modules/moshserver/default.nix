# Enables Mosh server

{ config, lib, ... }:

let
    name = "moshserver";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.mosh.enable = true;
    };
}
