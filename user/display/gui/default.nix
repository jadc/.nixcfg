{ pkgs, ... }:

{
    gtk = {
        enable = true;

        theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
        };

        font = {
            name = "Open Sans";
            package = pkgs.open-fonts;
        };

        cursorTheme = {
            name = "Bibata-Modern-Ice";
            package = pkgs.bibata-cursors;
            size = 24;
        };

        iconTheme = {
            name = "Papirus-Dark";
            package = pkgs.papirus-icon-theme;
        };

        gtk3.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
        gtk4.extraConfig.Settings = "gtk-application-prefer-dark-theme=1";
    };
    home.sessionVariables.GTK_THEME = "adwaita";

    qt = {
        enable = true;
        platformTheme.name = "adwaita";
        style = {
            name = "adwaita-dark";
        };
    };
}
