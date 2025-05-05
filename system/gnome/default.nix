{ lib, pkgs, ... }:

{
    services.xserver = {
        # Login server
        displayManager.gdm.enable = true;
        displayManager.gdm.wayland = true;

        # Gnome
        desktopManager.gnome.enable = true;
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
}
