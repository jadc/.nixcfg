{ config, lib, pkgs, ... }:

let
    name = "envs";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "enter";
                text = ''nix-shell "${./.}/$1"'';
            })
        ];
    };
}
