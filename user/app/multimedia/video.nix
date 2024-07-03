# Video manipulation tools

{ pkgs, ... }:

{
    imports = [ 
        ./ffmpeg.nix 
        ./yt.nix
    ];
    home.packages = with pkgs; [
        avidemux
    ];

    programs.obs-studio.enable = true;
}
