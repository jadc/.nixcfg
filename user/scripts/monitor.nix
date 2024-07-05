{ config, pkgs, ... }:

# Fix monitor layout
let
    monitor = pkgs.writeShellApplication {
        name = "monitor";
        text = ''
            ${pkgs.xorg.xrandr}/bin/xrandr --dpi 120 \
                --output ${config.monitors.primary} --mode 2560x1440 --scale 1x1 --pos 0x0 \
                --output ${config.monitors.secondary}   --mode 1920x1080 --scale 1x1 --pos 2560x-324 --rotate right
        '';
    };
in
{
    # Add script to pkgs
    home.packages = [ monitor ];

    # Add keybindings
    services.sxhkd.keybindings = {
        "super + alt + q" = "${monitor}/bin/monitor";
    };
}
