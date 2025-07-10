{ pkgs, ... }:

{
    home.packages = with pkgs; [ poppler-utils ];
}
