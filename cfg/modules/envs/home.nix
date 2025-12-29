{ config, lib, pkgs, ... }:

let
    name = "envs";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "enter";
                text = ''nix-shell "${toString ./.}/$1"'';
            })
        ];
    };
}
