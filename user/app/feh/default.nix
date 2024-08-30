# Feh: image viewer and wallpaper engine

{ pkgs, ... }:

{
    programs.feh.enable = true;

    # Enable wallpaper
    xsession.windowManager.bspwm.extraConfig = "${pkgs.feh}/bin/feh --bg-fill $HOME/.background-image";

    # Set as default image viewer
    xdg.mimeApps = {
        enable = true;
        defaultApplications = {
            "image" = [ "feh.desktop" ];
            "image/apng" = [ "feh.desktop" ];
            "image/avif" = [ "feh.desktop" ];
            "image/gif" = [ "feh.desktop" ];
            "image/jpeg" = [ "feh.desktop" ];
            "image/png" = [ "feh.desktop" ];
            "image/svg+xml" = [ "feh.desktop" ];
            "image/webp" = [ "feh.desktop" ];
        };
    };
}
