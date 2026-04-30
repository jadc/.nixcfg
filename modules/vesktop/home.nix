{ config, lib, pkgs, ... }:

let
    name = "vesktop";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.vesktop ];

        xdg.configFile."vesktop/settings/settings.json".source = ./settings.json;
    };
}
