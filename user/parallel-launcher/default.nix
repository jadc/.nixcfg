{ pkgs, ... }:

{
    home.packages = with pkgs; [ parallel-launcher ];
}
