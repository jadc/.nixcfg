{
    # Window Manager
    services.yabai = {
        enable = true;
        config = {
            # Render shadow only on floating windows
            window_shadow = "float";

            # Padding and gaps
            top_padding         = 10;
            bottom_padding      = 10;
            left_padding        = 10;
            right_padding       = 10;
            window_gap          = 10;
        };
        extraConfig = builtins.readFile ./rules;
    };

    # Hotkey daemon
    services.skhd = {
        enable = true;
        skhdConfig = builtins.readFile ./skhdrc;
    };
}
