{ config, lib, ... }:

let
    name = "systemd-boot";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        boot.loader = {
            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 5;
            efi.canTouchEfiVariables = true;
            timeout = 0;
        };
    };
}
