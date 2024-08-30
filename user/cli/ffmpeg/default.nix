# The most important FOSS project ever made.

{ pkgs, ... }:

{
    home.packages = with pkgs; [ ffmpeg ];
}
