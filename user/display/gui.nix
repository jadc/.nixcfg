{ pkgs, ... }:

{
    home.packages = [
        pkgs.dconf
    ];

    gtk = {
        enable = true;
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
        };
        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };
        font = {
            name = "Open Sans";
            package = pkgs.open-fonts;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style = {
            name = "adwaita-dark";
        };
    };
}
