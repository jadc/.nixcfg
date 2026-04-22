{ config, lib, pkgs, ... }:

let
    name = "puddletag";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.puddletag ];
    };
}
