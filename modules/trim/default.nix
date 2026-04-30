{ config, lib, ... }:

let
    name = "trim";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.fstrim.enable = true;
    };
}
