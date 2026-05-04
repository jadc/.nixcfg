{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            image = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
                description = "Path to wallpaper image";
            };
            mode = lib.mkOption {
                type = lib.types.enum [ "fill" "fit" "center" "stretch" "tile" ];
                default = "fill";
            };
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf (self.image != null) {
            home.packages = [ pkgs.swaybg ];

            systemd.user.services.swaybg = {
                Unit = {
                    Description = "Wallpaper daemon";
                    PartOf = [ "graphical-session.target" ];
                    After = [ "graphical-session.target" ];
                };
                Service = {
                    ExecStart = "${pkgs.swaybg}/bin/swaybg -i ${self.image} -m ${self.mode}";
                    Restart = "on-failure";
                };
                Install.WantedBy = [ "graphical-session.target" ];
            };
        };
    };
}
