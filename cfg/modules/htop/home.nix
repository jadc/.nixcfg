{ config, lib, pkgs, ... }:

let
    name = "htop";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.htop.enable = true;
        home.packages = with pkgs; [ killall ];
    };
}
