{ config, lib, ... }:

let
    name = "automount";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.devmon.enable = true;
        services.gvfs.enable = true;
        services.udisks2.enable = true;
    };
}
