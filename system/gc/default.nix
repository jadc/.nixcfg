{ config, lib, pkgs, ... }:

{
    nix.gc = {
        automatic = true;
        options = "--delete-older-than 7d";
    }
    // lib.optionalAttrs pkgs.stdenv.isLinux {
        dates = "weekly";
    }
    // lib.optionalAttrs pkgs.stdenv.isDarwin {
        user = config.common.username;
        interval = [{ Hour = 21; Minute = 0; Weekday = 7; }];
    };
}
