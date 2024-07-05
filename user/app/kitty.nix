{ pkgs, ... }:

{
    programs.kitty = {
        enable = true;

        font = {
            package = pkgs.jetbrains-mono;
            name = "JetBrains Mono Medium";
            size = 16;
        };

        keybindings = {
            "kitty_mod+equal" = "change_font_size all +1.0";
            "kitty_mod+minus" = "change_font_size all -1.0";
        };

        settings = {
            enable_audio_bell = false;
            update_check_interval = 0;
            window_padding_width = 24;
        };

        extraConfig = ''
            # Misc
            kitty_mod ctrl+alt

            # Colors
            color0 #252525
            color8 #535353

            #: black
            color1 #ff009e
            color9 #ff009e

            #: red
            color2  #00ffa2
            color10 #00ffa2

            #: green
            color3  #fffd00
            color11 #fffd00

            #: yellow
            color4  #00e0ff
            color12 #00efff

            #: blue
            color5  #ff00d4
            color13 #ff00d4

            #: magenta
            color6  #00ffea
            color14 #00ffea

            #: cyan
            color7  #ffffff
            color15 #ffffff

            #: white
            mark1_foreground black

            #: Color for marks of type 1
            mark1_background #98d3cb

            #: Color for marks of type 1 (light steel blue)
            mark2_foreground black

            #: Color for marks of type 2
            mark2_background #f2dcd3

            #: Color for marks of type 1 (beige)
            mark3_foreground black

            #: Color for marks of type 3
            mark3_background #f274bc
        '';
    };

    # Create keybinding to open kitty
    services.sxhkd.keybindings = {
        "super + Return" = "${pkgs.kitty}/bin/kitty";
    };
}
