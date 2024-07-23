{ pkgs, ... }:

{
    fonts = {
        packages = with pkgs; [
            noto-fonts
            open-sans
            twemoji-color-font
            ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )

            # Default fonts
            dejavu_fonts
            freefont_ttf
            gyre-fonts   # TrueType substitutes for standard PostScript fonts
            liberation_ttf
            unifont
        ];

        fontconfig = {
            defaultFonts = {
                serif = [ "Noto Serif" ];
                sansSerif = [ "Open Sans" ];
                monospace = [ "JetBrains Mono" ];
                emoji = [ "Twemoji Color Emoji" ];
            };
        };
    };
}
