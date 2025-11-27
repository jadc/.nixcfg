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

        xdg = lib.optionalAttrs pkgs.stdenv.isLinux {
            # Set as default PDF viewer
            # TODO: create zathura.desktop
            mimeApps = {
                enable = true;
                defaultApplications = {
                    "application/pdf" = [ "zathura.desktop" ];
                };
            };
        };
    };
}
