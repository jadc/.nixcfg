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
            programs.zathura = {
                enable = true;
                mappings = {
                    "<C-r>" = "recolor";
                };
            };

            xdg.mimeApps = lib.mkIf pkgs.stdenv.isLinux {
                enable = true;
                defaultApplications = {
                    "application/pdf" = "org.pwmt.zathura.desktop";
                };
            };
        };
    };
}
