{ pkgs, ... }:

let
    spotifyify = pkgs.writeShellApplication {
        name = "spotifyify";
        text = ''
            mv "$1" "$1.old"
            FILE_NAME="''${1%%.*}"
            ffmpeg -i "$1.old" -hide_banner \
                -y \
                -vn \
                -b:a 320k \
                -metadata artist="$2" \
                -metadata title="''${FILE_NAME//_/ }" \
                -metadata album="Unreleased" \
                "$FILE_NAME.mp3"
        '';
    };
in
{
    # Add script to pkgs
    home.packages = [ spotifyify ];
}
