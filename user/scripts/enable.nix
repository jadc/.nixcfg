{ pkgs, ... }:

{
    # Adds the scripts/bin directory to the user PATH
    # TODO: make these actual nix packages
    config.home.packages = [ 
        (pkgs.buildEnv { name = "scripts"; paths = [ ./. ]; }) 
    ];
}
