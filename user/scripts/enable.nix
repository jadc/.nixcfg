{ pkgs, ... }:

{
    # Adds the scripts/bin directory to the user PATH
    config.home.packages = [ 
        (pkgs.buildEnv { name = "scripts"; paths = [ ./../../user/scripts ]; }) 
    ];
}
