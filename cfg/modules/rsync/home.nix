{ config, lib, pkgs, ... }:

let
    name = "rsync";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.rsync ];

        cfg.const.aliases.rsync="rsync -avhP --no-compress";
    };
}
