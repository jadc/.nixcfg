# Image manipulation tools

{ pkgs, ... }:

{
    home.packages = with pkgs; [
        imagemagick
        gimp
        inkscape
    ];
}
