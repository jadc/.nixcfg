{ config, lib, pkgs, ... }:

let
    name = "envs";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "enter";
                text = ''nix-shell "${./.}/$1"'';
            })
        ];
    };
}
