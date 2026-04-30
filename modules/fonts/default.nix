{ config, lib, pkgs, ... }:

let
    name = "fonts";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        fonts = {
            packages = [
                pkgs.jetbrains-mono
                pkgs.nerd-fonts.jetbrains-mono
                pkgs.noto-fonts
                pkgs.open-sans
                pkgs.twemoji-color-font

                # Default fonts
                pkgs.dejavu_fonts
                pkgs.freefont_ttf
                pkgs.gyre-fonts   # TrueType substitutes for standard PostScript fonts
                pkgs.liberation_ttf
                pkgs.unifont
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
