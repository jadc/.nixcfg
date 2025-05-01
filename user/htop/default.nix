{ pkgs, ... }:

{
    programs.htop.enable = true;
    home.packages = with pkgs; [ killall ];
}
