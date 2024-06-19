{ config, lib, ... }:

{
    options = {
        monitors = {
            primary = lib.mkOption {
                type = lib.types.str;
                default = "";
            };
            secondary = lib.mkOption { 
                type = lib.types.str; 
                default = "";
            };
        };
    };

    config = {
        # Enable Xsession for user
        xsession.enable = true;

        # Bspwm
        xsession.windowManager.bspwm = {
            enable = true;

            settings = {
                border_width = 0;
                window_gap = 8;

                split_ratio = 0.5;
                borderless_monocle = true;
                single_monocle = true;
                gapless_monocle = true;

                # 60Hz = 17, 144Hz = 7, 240Hz = 4
                pointer_motion_interval = 4;
            };

            monitors = 
                let
                    primary = config.monitors.primary;
                    secondary = config.monitors.secondary;
                in {
                    ${primary} = [ "I" "II" "III" "IV" "V" "VI" ];
                    ${secondary} = [ "VII" "VIII" "IX" ];
                };
        };

        # Hotkey daemon
        services.sxhkd = {
            enable = true;

            keybindings = {};
        };
    };
}
