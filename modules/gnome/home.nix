{ config, lib, ... }:

let
    name = "gnome";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ./extensions ];

    config = lib.mkIf self.enable {
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
