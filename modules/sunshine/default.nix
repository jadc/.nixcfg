{ config, lib, ... }:

let
    name = "sunshine";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.sunshine = {
            enable = true;
            autoStart = true;
            capSysAdmin = true;
            openFirewall = true;
        };
    };
}
