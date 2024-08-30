{ config, lib, pkgs, ... }:

{
    # Common
    nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
        # NixOS
        dates = "weekly";
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
        # nix-darwin
        user = config.common.username;
        interval = [{ Hour = 21; Minute = 0; Weekday = 7; }];
    };
}
