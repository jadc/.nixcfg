{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.btop = {
                enable = true;
                settings.theme_background = false;
            };

            home.packages = [ pkgs.killall ];

            cfg.const.aliases = let
                topclient = "${pkgs.btop}/bin/btop";
            in {
                btop = topclient;
                htop = topclient;
                top = topclient;
            };
        };
    };
}
