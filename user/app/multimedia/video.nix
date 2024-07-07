# Video manipulation tools

{ pkgs, ... }:

{
    imports = [
        ./ffmpeg.nix
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
