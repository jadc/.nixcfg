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
            name = "whitesur-gtk-theme";
            package = pkgs.whitesur-gtk-theme;
        };
        font = {
            name = "Open Sans";
            package = pkgs.open-fonts;
        };
    };

    qt = {
        enable = true;
        platformTheme.name = "gtk";
        style = {
            name = "adwaita-dark";
            package = pkgs.adwaita-qt;
        };
    };
}
