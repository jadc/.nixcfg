{ config, lib, ... }:

let
    name = "ssh";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        services.openssh.enable = true;
        services.openssh.settings.X11Forwarding = true;
    };
}
