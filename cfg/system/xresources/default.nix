{ config, lib, ... }:

let
    name = "xresources";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        xresources.properties = {
            "Xft.antialias" = "true";
            "Xft.autohint" = "false";
            #"Xft.dpi" = 96;
            "Xft.dpi" = 120;
            "Xft.hinting" = "true";
            "Xft.hintstyle" = "hintslight";
            "Xft.lcdfilter" = "lcddefault";
            "Xft.rgba" = "rgb";
        };
    };
}
