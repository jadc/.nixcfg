{ config, lib, ... }:

let
    name = "direnv";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.direnv = {
            enable = true;
            enableBashIntegration = true;
            enableZshIntegration = true;
            nix-direnv.enable = true;
        };
    };
}
