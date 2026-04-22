{ config, lib, pkgs, ... }:

let
    name = "brave";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

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
