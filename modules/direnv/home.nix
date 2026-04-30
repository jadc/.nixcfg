{ config, lib, ... }:

let
    name = "direnv";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.direnv = {
            enable = true;
            enableBashIntegration = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;
        };
    };
}
