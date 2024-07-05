{ pkgs, ... }:

{
    fonts = {
        enableDefaultPackages = true;

        packages = with pkgs; [
            noto-fonts
            open-sans
            twemoji-color-font
            ( nerdfonts.override { fonts = [ "JetBrainsMono" ]; } )
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
