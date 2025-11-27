{ config, lib, ... }:

let
    name = "autorandr";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.autorandr.enable = true;
        services.autorandr.enable = true;
    };
}
