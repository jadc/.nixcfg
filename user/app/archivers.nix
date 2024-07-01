# Installs a number of archiving and unarchiving tools

{ pkgs, ... }:

{
    home.packages = with pkgs; [
        zip unzip
        p7zip
    ];
}
