{ config, lib, ... }:

let
    name = "gnome";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        monitors = mkOption {
            type = types.nullOr types.path;
            default = null;
            description = "Path to monitors.xml file for GNOME display configuration";
        };
    };

    imports = [ ./extensions ];

    config = {
        # GNOME Configuration
        dconf.enable = true;
        dconf.settings = {
            # Enable dark theme
            "org/gnome/desktop/interface" = {
                color-scheme = "prefer-dark";
                accent-color = "slate";
            };

            # Custom 12 hour clock
            "org/gnome/desktop/interface" = {
                clock-format = "12h";
                clock-show-weekday = false;
                clock-show-date = false;
                clock-show-seconds = true;
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

            "org/gnome/desktop/interface" = {
                # Text scaling
                text-scaling-factor = 0.85;

                # Show battery percentage
                show-battery-percentage = true;
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
    };
}
