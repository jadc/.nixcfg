{ config, ... }:

{
    imports = [
        ./../../modules
        ./../../modules/gnome/home.nix
        ./../../modules/Scripts/rebuild.nix
        ./../../modules/Scripts/spotifyify.nix
        ./common.nix
    ];
}
