{ config, lib, pkgs, ... }:

let
    name = "spotifyify";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [
            (pkgs.writeShellApplication {
                name = "spotifyify";
                runtimeInputs = [ pkgs.ffmpeg ];
                text = builtins.readFile ./spotifyify.sh;
            })
        ];
    };
}
