{ config, lib, ... }:

let
    name = "go";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.go = {
            enable = true;
            env.GOPATH = ".go";
        };
    };
}
