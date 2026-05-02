{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            monitors = lib.mkOption {
                type = lib.types.nullOr lib.types.path;
                default = null;
                description = "Path to monitors.xml file for GNOME display configuration";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
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

            cfg.impermanence.root.dirs = [ "/var/lib/AccountsService" ];
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.gnomeExtensions.just-perfection ];

            # GNOME Configuration
            dconf.enable = true;
            dconf.settings = {
                "org/gnome/desktop/interface" = {
                    # Dark theme
                    color-scheme = "prefer-dark";
                    accent-color = "slate";

                    # 12 hour clock
                    clock-format = "12h";
                    clock-show-weekday = false;
                    clock-show-date = false;
                    clock-show-seconds = true;

                    # Text scaling
                    text-scaling-factor = 0.85;

                    # Show battery percentage
                    show-battery-percentage = true;
                };
                "org/gtk/settings/file-chooser".clock-format = "12h";

                # Solid black background
                "org/gnome/desktop/background" = {
                    picture-options = "none";
                    primary-color = "#000000";
                };

                # Disable mouse acceleration
                "org/gnome/desktop/peripherals/mouse" = {
                    accel-profile = "flat";
                };

                # Enable Night Shift
                "org/gnome/settings-daemon/plugins/color" = {
                    night-light-schedule-automatic = true;
                };

                "org/gnome/settings-daemon/plugins/power" = {
                    # Power button => power off
                    power-button-action = "interactive";

                    # Disable sleeping
                    sleep-inactive-ac-type = "nothing";
                };

                "org/gnome/nautilus/preferences" = {
                    # Set default folder view to details
                    default-folder-viewer = "list-view";

                    # Always show path in title bar
                    always-use-location-entry = true;
                };

                # Enable just-perfection extension
                "org/gnome/shell" = {
                    disable-user-extensions = false;
                    enabled-extensions = [
                        pkgs.gnomeExtensions.just-perfection.extensionUuid
                    ];
                };

                "org/gnome/shell/extensions/just-perfection" = {
                    # Shutup
                    support-notifier-type = 0;

                    # Hide quick settings toggles
                    quick-settings-dark-mode = false;
                    quick-settings-airplane-mode = false;

                    # Hide clock menu components
                    world-clock = false;
                    calendar = false;
                    events-button = false;

                    # Start on desktop
                    startup-status = 0;

                    # Faster UI animation
                    animation = 4;

                    # Smaller icons
                    dash-icon-size = 48;
                    alt-tab-icon-size = 32;

                    # Popups from right
                    notification-banner-position = 2;
                    osd-position = 6;
                };

                # Screenshot keybinding
                "org/gnome/shell/keybindings" = {
                    show-screenshot-ui = ["Print" "<Super><Shift>s"];
                };
            };

            # Monitor configuration
            xdg.configFile."monitors.xml" = lib.mkIf (self.monitors != null) {
                source = self.monitors;
                force = true;
            };

            # Login keyring
            cfg.impermanence.home.dirs = [ ".local/share/keyrings" ];
        };
    };
}
