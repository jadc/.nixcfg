{ config, lib, pkgs, ... }:

let
    name = "flac";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.flac ];

        cfg.const.aliases.wavtoflac = "${pkgs.flac}/bin/flac --best --delete-input-file -e -p -V -f --keep-foreign-metadata *.wav";
    };
}
