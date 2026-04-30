{ config, lib, pkgs, ... }:

let
    name = "zathura";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

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
