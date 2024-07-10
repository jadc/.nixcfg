# flac: A command-line flac encoder/decoder

{ pkgs, ... }:

{
    home.packages = with pkgs; [ flac ];

    common.aliases.wavtoflac = "${pkgs.flac}/bin/flac --best --delete-input-file -e -p -V -f --keep-foreign-metadata *.wav";
}
