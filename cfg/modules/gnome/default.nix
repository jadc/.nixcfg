{ config, lib, pkgs, ... }:

let
    name = "gnome";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Import home-manager config when this module is enabled
        home-manager.sharedModules = [ ./home.nix ];

        services.desktopManager.gnome.enable = true;

        # Login server
        services.displayManager.gdm = {
            enable = true;
            wayland = true;
            autoSuspend = false;
        };

        environment.defaultPackages = [
            pkgs.gnome-tweaks
            pkgs.xdg-desktop-portal
            pkgs.xdg-desktop-portal-gnome
        ];

        environment.gnome.excludePackages = [
            pkgs.atomix            # puzzle game
            pkgs.cheese            # webcam tool
            pkgs.epiphany          # web browser
            pkgs.evince            # document viewer
            pkgs.geary             # email reader
            pkgs.gedit             # text editor
            pkgs.gnome-characters
            pkgs.gnome-music
            pkgs.gnome-photos
            pkgs.gnome-terminal
            pkgs.gnome-tour
            pkgs.hitori            # sudoku game
            pkgs.iagno             # go game
            pkgs.tali              # poker game
            pkgs.totem             # video player
        ];
    };
}
