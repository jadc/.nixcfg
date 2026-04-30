{ config, lib, ... }:

let
    name = "qt";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

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
