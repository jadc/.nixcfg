# Audio manipulation tools

{ common, pkgs, ... }:

{
    home.packages = with pkgs; [
        audacity
        spek
        flac
    ];

    # TODO: make this work
    # aliases.wavtoflac = "${pkgs.flac}/bin/flac --best --delete-input-file -e -p -V -f --keep-foreign-metadata *.wav";
}
