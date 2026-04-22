{ config, lib, ... }:

let
    name = "sunshine";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.sunshine = {
            enable = true;
            autoStart = true;
            capSysAdmin = true;
            openFirewall = true;
        };
    };
}
