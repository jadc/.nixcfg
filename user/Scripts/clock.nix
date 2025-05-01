{ pkgs, ... }:

let
    clock = pkgs.writeShellApplication {
        name = "clock";
        text = ''
            if [ "$#" -gt 0 ]; then
                # Verbose
                FORMAT="%A, %B %-d, %Y"
            else
                # Simple
                FORMAT="%-I:%M %p"
            fi

            # Display volume even if no argument is given
            ${pkgs.libnotify}/bin/notify-send -u low -r 70 -t 5000 "$(date +"$FORMAT")"
        '';
    };
in
{
    # Add script to pkgs
    home.packages = [ clock ];

    # Add keybindings
    services.sxhkd.keybindings = {
        "Pause" = "${clock}/bin/clock";
        "ctrl + Pause" = "${clock}/bin/clock -v";
    };
}
