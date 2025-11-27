{ config, lib, pkgs, ... }:

let
    name = "gnome";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        services.desktopManager.gnome.enable = true;

        # Login server
        services.displayManager.gdm = {
            enable = true;
            wayland = true;
            autoSuspend = false;
        };

        environment.defaultPackages = with pkgs; [
            gnome-tweaks
            xdg-desktop-portal
            xdg-desktop-portal-gnome
        ];

        environment.gnome.excludePackages = (with pkgs; [
            atomix            # puzzle game
            cheese            # webcam tool
            epiphany          # web browser
            evince            # document viewer
            geary             # email reader
            gedit             # text editor
            gnome-characters
            gnome-music
            gnome-photos
            gnome-terminal
            gnome-tour
            hitori            # sudoku game
            iagno             # go game
            tali              # poker game
            totem             # video player
        ]);

        # Allow GNOME to set the timezone
        time.timeZone = lib.mkForce null;
    };
}
