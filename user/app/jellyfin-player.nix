# Jellyfin Media Player: A media player for Jellyfin

{ pkgs, ... }:

{
    home.packages = with pkgs; [ jellyfin-media-player ];
}
