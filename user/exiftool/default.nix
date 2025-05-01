# Exiftool: Read and write meta information in files

{ pkgs, ... }:

{
    home.packages = with pkgs; [ exiftool ];
}
