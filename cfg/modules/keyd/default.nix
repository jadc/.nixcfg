{ config, lib, ... }:

let
    name = "keyd";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.keyd.enable = true;
        environment.etc."keyd/default.conf".source = ./keyd.conf;
    };
}
