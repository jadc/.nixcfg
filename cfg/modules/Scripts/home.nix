{ config, lib, pkgs, ... }:

let
    name = "Scripts";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        # Adds any scripts in ./bin to the user PATH
        home.packages = [
            (pkgs.buildEnv { name = "scripts"; paths = [ ./. ]; })
        ];
    };
}
