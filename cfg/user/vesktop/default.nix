{ config, lib, pkgs, ... }:

let
    name = "vesktop";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [ vesktop ];

        home.file.vesktop = {
            source = ./settings.json;
            target = "${config.xdg.configHome}/vesktop/settings/settings.json";
        };
    };
}
