{
    imports = [ ./extensions ];

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

        # Automatic timezone
        "org/gnome/system/location".enabled = true;
        "org/gnome/desktop/datetime".automatic-timezone = true;

        # Text scaling
        "org/gnome/desktop/interface" = {
            text-scaling-factor = 0.85;
        };

        # Caps to escape
        "org/gnome/desktop/input-sources" = {
            xkb-options = ["caps:escape"];
        };

        # Disable sleeping
        "org/gnome/settings-daemon/plugins/power" = {
            sleep-inactive-ac-type = "nothing";
        };
    };

    # Black title bar
    /*
    xdg.configFile."gtk-3.0/gtk.css".text = ''
        window.ssd headerbar.titlebar {
            background-color: #000000;
            color: white;
        }
    '';
    */
}
