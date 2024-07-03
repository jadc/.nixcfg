# Nautilus: Gnome file manager

{ pkgs, ... }:

{
    home.packages = with pkgs; [ gnome.nautilus ];
}
