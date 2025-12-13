{ config, lib, pkgs, ... }:

let
    name = "fonts";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        fonts = {
            packages = with pkgs; [
                jetbrains-mono
                nerd-fonts.jetbrains-mono
                noto-fonts
                open-sans
                twemoji-color-font

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

        # Better font rendering
        environment.sessionVariables = {
            FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
        };
    };
}
