{ config, lib, pkgs, ... }:

let
    name = "htop";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.htop.enable = true;
        home.packages = [ pkgs.killall ];
    };
}
