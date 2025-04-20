{ config, pkgs, lib, ... }:

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
                window_gap = 0;

                split_ratio = 0.5;
                borderless_monocle = true;
                single_monocle = true;
                gapless_monocle = true;

                # 60Hz = 17, 144Hz = 7, 240Hz = 4
                pointer_motion_interval = 7;
            };

            monitors = let
                primary = config.monitors.primary;
                secondary = config.monitors.secondary;
            in {
                ${primary} = if secondary != "" then
                    [ "I" "II" "III" "IV" "V" "VI" ]
                else
                    [ "I" "II" "III" "IV" "V" "VI" "VII" "VIII" "IX" ];
                ${secondary} = [ "VII" "VIII" "IX" ];
            };
        };

        # Remap caps to escape
        services.xserver.xkb.options = "caps:escape";

        # Hotkey daemon
        services.sxhkd = {
            enable = true;

            keybindings = {
                # Close and kill
                "super + {_,shift + }w" = "${pkgs.bspwm}/bin/bspc node -{c,k}";

                # Set the window state
                "super + {t,shift + t,s,f}" = "${pkgs.bspwm}/bin/bspc node -t {tiled,pseudo_tiled,floating,fullscreen}";

                # Move focus
                "super + {_,shift + }{h,j,k,l}" = "${pkgs.bspwm}/bin/bspc node -{f,s} {west,south,north,east}";

                # Focus or send to desktop
                "super + {_,shift + }{1-9,0}" = "${pkgs.bspwm}/bin/bspc {desktop -f,node -d} '^{1-9,10}'";

                # Move a floating window
                "super + {Left,Down,Up,Right}" = "${pkgs.bspwm}/bin/bspc node -v {-20 0,0 20,0 -20,20 0}";
            };
        };
    };
}
