{ config, lib, pkgs, ... }:

let
    name = "moonlight";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.moonlight-qt ];
    };
}
