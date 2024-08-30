# zathura: pdf viewer

{
    programs.zathura = {
        enable = true;
        mappings = {
            "<C-r>" = "recolor";
        };
    };

    # Set as default PDF viewer
    # TODO: create zathura.desktop
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "application/pdf" = [ "zathura.desktop" ];
        };
    };
}
