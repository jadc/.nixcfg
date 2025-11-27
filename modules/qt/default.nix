{ config, lib, ... }:

let
    name = "qt";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        qt = {
            enable = true;
            platformTheme.name = "adwaita";
            style = {
                name = "adwaita-dark";
            };
        };
    };
}
