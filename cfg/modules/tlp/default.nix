{ config, lib, ... }:

let
    name = "tlp";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.tlp.enable = true;
    };
}
