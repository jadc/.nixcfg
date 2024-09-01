{ lib, pkgs, ... }:

{
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

}
