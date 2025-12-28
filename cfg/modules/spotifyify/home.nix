{ config, lib, pkgs, ... }:

let
    name = "spotifyify";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

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
