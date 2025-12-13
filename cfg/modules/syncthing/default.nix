{ config, lib, ... }:

let
    name = "syncthing";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.syncthing = {
            enable = true;
            openDefaultPorts = true;
            user = config.cfg.const.username;
            group = "wheel";
        };
    };
}
