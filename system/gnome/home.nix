{
    dconf.settings = {
        "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            accent-color = "slate";

            # Clock
            clock-format = "12h";
            clock-show-weekday = false;
            clock-show-date = false;
            clock-show-seconds = true;
        };

        # Disable mouse acceleration
        "org/gnome/desktop/peripherals/mouse" = {
            accel-profile = "flat";
        };

        # Night Shift
        "org/gnome/settings-daemon/plugins/color" = {
            night-light-enabled = true;
        };

        # Automatic timezone
        "org/gnome/desktop/datetime" = {
            automatic-timezone = true;
        };

        # 12 hour clock
        "org/gtk/settings/file-chooser" = {
            clock-format = "12h";
        };
    };
}
