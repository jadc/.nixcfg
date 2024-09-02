{ pkgs, ... }:

{
    home.packages = with pkgs; [
        jetbrains.clion
        cmake
        ninja
    ];
}
