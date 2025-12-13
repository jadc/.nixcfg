# Rsync: a fast, versatile, remote (and local) file-copying tool

{ config, lib, pkgs, ... }:

let
    name = "rsync";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [ rsync ];

        cfg.const.aliases.rsync="rsync -avhP --no-compress";
    };
}
