{ config, lib, ... }:

let
    name = "picom";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.picom = {
            enable = true;
            settings = {
                /* corner-radius = 12; */
            };
        };
    };
}
