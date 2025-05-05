{ config, lib, pkgs, ... }:

{
    options.gnome.extensions.just-perfection.enable = lib.mkEnableOption {};
    config = lib.mkIf config.gnome.extensions.just-perfection.enable {
        home.packages = with pkgs; [ gnomeExtensions.just-perfection ];
        dconf = {
            enable = true;
            settings = {
                # Enable extension
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
            };
        };
    };
}
