{ pkgs, ... }:

{
    # Nixified scripts
    imports = [
        ./volume.nix
        ./clock.nix
        ./monitor.nix
        ./update.nix
    ];

    # Adds any scripts in ./bin to the user PATH
    home.packages = [
        (pkgs.buildEnv { name = "scripts"; paths = [ ./. ]; })
    ];
}
