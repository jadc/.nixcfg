{ config, lib, pkgs, ... }:

let
    name = "brave";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.chromium = {
            enable = true;
            package = pkgs.brave;
            commandLineArgs = [
                "--disable-features=WebRtcAllowInputVolumeAdjustment"
            ];
        };
    };
}
