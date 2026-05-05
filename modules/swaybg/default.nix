{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            wallpaper = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
            };
            mode = lib.mkOption {
                type = lib.types.enum [ "stretch" "fit" "fill" "center" "tile" "solid_color" ];
                default = "fill";
            };
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf (self.wallpaper != null || self.mode == "solid_color") {
            systemd.user.services.swaybg = {
                Unit = {
                    Description = "Wallpaper daemon";
                    PartOf = [ "graphical-session.target" ];
                    After = [ "graphical-session.target" ];
                };
                Service = {
                    ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${self.wallpaper} -m ${self.mode} -c 000000";
                    Restart = "on-failure";
                };
                Install.WantedBy = [ "graphical-session.target" ];
            };
        };
    };
}
