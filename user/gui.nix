{ pkgs, ... }:

{
    gtk = {
        enable = true;
        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
        };
        theme = {
            package = pkgs.adw-gtk3;
            name = "adw-gtk3";
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
