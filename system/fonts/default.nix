{ lib, pkgs, ... }:

{
    fonts = {
        packages = with pkgs; [
            jetbrains-mono
            nerd-fonts.jetbrains-mono

        ] ++ (if pkgs.stdenv.isLinux then [
            noto-fonts
            open-sans
            twemoji-color-font

            # Default fonts
            dejavu_fonts
            freefont_ttf
            gyre-fonts   # TrueType substitutes for standard PostScript fonts
            liberation_ttf
            unifont
        ] else []);
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
        fontconfig = {
            defaultFonts = {
                serif = [ "Noto Serif" ];
                sansSerif = [ "Open Sans" ];
                monospace = [ "JetBrains Mono" ];
                emoji = [ "Twemoji Color Emoji" ];
            };
        };

        # Better font rendering
        environment.sessionVariables = {
            FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
        };
    };
}
