{ pkgs, ... }:

{
    # Adds any scripts in ./bin to the user PATH
    home.packages = [
        (pkgs.buildEnv { name = "scripts"; paths = [ ./. ]; })
    ];
}
