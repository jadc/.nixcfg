# Redshift: Night shift

{ config, lib, ... }:

let
    name = "redshift";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.redshift = {
            enable = true;
            dawnTime = "7:00-8:00";
            duskTime = "16:00-17:00";
        };
    };
}
