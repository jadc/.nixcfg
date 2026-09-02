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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let
        self = config.cfg.${name};
        style = config.cfg.style;
    in {
        config = lib.mkIf self.enable {
            programs.zathura = {
                enable = true;
                options.default-bg = lib.mkForce (style.colors.base00.rgba style.opacity.applications);
                mappings = {
                    "<C-r>" = "recolor";
                };
            };

            xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
                enable = true;
                defaultApplications = {
                    "application/pdf" = "org.pwmt.zathura.desktop";
                };
            };
        };
    };
}
