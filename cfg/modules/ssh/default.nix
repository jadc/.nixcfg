{ config, lib, ... }:

let
    name = "ssh";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.openssh.enable = true;
        services.openssh.settings.X11Forwarding = true;
    };
}
