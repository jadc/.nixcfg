# Audacity: A free, open source, cross-platform software for recording and editing sounds.

{ pkgs, ... }:

{
    home.packages = with pkgs; [ audacity ];
}
