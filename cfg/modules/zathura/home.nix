{ config, lib, pkgs, ... }:

let
    name = "zathura";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

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
}
