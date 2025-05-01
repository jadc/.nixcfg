# Dunst: notifications display

{ pkgs, ... }:

{
    home.packages = with pkgs; [ libnotify ];
    services.dunst = {
        enable = true;
        settings = {
            global = {
                # Font
                font = "Open Sans";

                # Position
                offset = "10x10";
                origin = "bottom-right";

                # Min and max width
                width = "(0, 300)";

                # No border radius
                frame_width = 0;

                # Padding
                horizontal_padding = 12;
                padding = 12;

                # Transparency
                transparency = 10;
            };
        };
    };
}
