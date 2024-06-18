{ pkgs, ... }:

{
    fonts.packages = with pkgs; [
        jetbrains-mono
        nerdfonts
        twemoji-color-font
    ];
}
