{ config, lib, ... }:

let
    name = "x2go";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.x2goserver.enable = true;
    };
}
