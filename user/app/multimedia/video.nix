# Video manipulation tools

{ pkgs, ... }:

{
    imports = [ 
        ./ffmpeg.nix 
        ./yt.nix
    ];
    home.packages = with pkgs; [
        avidemux
        jellyfin-media-player
    ];

    programs.obs-studio.enable = true;

    programs.mpv = {
        enable = true;
    };
}
