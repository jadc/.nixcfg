{ config, lib, pkgs, ... }:

let
    name = "gc";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        nix.gc = {
            automatic = true;
            options = "--delete-older-than 7d";
        }
        // lib.optionalAttrs pkgs.stdenv.isLinux {
            dates = "weekly";
        }
        // lib.optionalAttrs pkgs.stdenv.isDarwin {
            user = config.cfg.const.username;
            interval = [{ Hour = 21; Minute = 0; Weekday = 7; }];
        };
    };
}
