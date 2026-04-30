{ config, lib, pkgs, ... }:

let
    name = "rsync";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.rsync ];

        cfg.const.aliases.rsync="rsync -avhP --no-compress";
    };
}
