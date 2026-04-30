{ config, lib, ... }:

let
    name = "x2go";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.x2goserver.enable = true;
    };
}
