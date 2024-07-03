# Audio manipulation tools

{ config, pkgs, ... }:

{
    config = {
        home.packages = with pkgs; [
            audacity
            spek
            flac
            puddletag
            exiftool
        ];

        common.aliases.wavtoflac = "${pkgs.flac}/bin/flac --best --delete-input-file -e -p -V -f --keep-foreign-metadata *.wav";
    };
}
