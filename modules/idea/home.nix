{ config, lib, pkgs, ... }:

let
    name = "idea";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.jetbrains.idea-community-bin ];
    };
}
