{ pkgs, ... }:

# Script for adjusting volume
let
    volume = pkgs.writeShellApplication {
        name = "volume";
        text = ''
            adjust_volume () {
                ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_AUDIO_SINK@ "2%$1"
            }

            if [ "$#" -gt 0 ]; then
                if [ "$1" = "up" ]; then
                    adjust_volume +
                elif [ "$1" = "down" ]; then
                    adjust_volume -
                elif [ "$1" = "mute" ]; then
                    ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
                fi
            fi

            # Display volume even if no argument is given
            VOLUME=$( ${pkgs.wireplumber}/bin/wpctl get-volume @DEFAULT_AUDIO_SINK@ )
            ${pkgs.libnotify}/bin/notify-send -u low -r 70 -t 3000 "$VOLUME"
        '';
    };
in
{
    # Add script to pkgs
    home.packages = [ volume ];

    # Add keybindings for adjusting volume
    services.sxhkd.keybindings = {
        "Prior" = "${volume}/bin/volume up";
        "Next" = "${volume}/bin/volume down";
        "ctrl + Next" = "${volume}/bin/volume mute";
    };
}
