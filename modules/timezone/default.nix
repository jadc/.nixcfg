{ config, lib, ... }:

let
    name = "timezone";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.tzupdate.enable = true;

        # Allow timezone to be modified dynamically
        time.timeZone = lib.mkForce null;
    };
}
