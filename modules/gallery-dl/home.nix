{ config, lib, ... }:

let
    name = "gallery-dl";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.gallery-dl.enable = true;
    };
}
