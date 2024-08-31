{ config, pkgs, ... }:

{
    home.packages = with pkgs; [ vesktop ];

    home.file.vesktop = let
        configHome = if pkgs.stdenv.isDarwin
            then "/Library/Application Support"
            else "${config.xdg.configHome}";
    in {
        source = ./settings.json;
        target = "${configHome}/vesktop/settings/settings.json";
    };
}
