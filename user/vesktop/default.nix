{ config, pkgs, ... }:

{
    home.packages = with pkgs; [ vesktop ];

    home.file.vesktop = {
        source = ./settings.json;
        target = "${config.xdg.configHome}/vesktop/settings/settings.json";
    };
}
