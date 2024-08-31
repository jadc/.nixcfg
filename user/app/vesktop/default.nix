{ lib, pkgs, ... }:

{
    home.packages = with pkgs; [ vesktop ];

    # Configuration
    xdg.configFile.vesktop = lib.mkIf pkgs.stdenv.isLinux {
        source = ./settings.json;
        target = "vesktop/settings/settings.json";
    };

    # If on macOS, symlink to where config is read on macOS
    # /Users/jad/Library/Application Support/vesktop
    home.file.vesktop = lib.mkIf pkgs.stdenv.isDarwin {
        source = ./settings.json;
        target = "Library/Application Support/vesktop/settings.json";
    };
}
