{ config, lib, ... }:

let
    name = "systemd-boot";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        boot.loader = {
            systemd-boot.enable = true;
            systemd-boot.configurationLimit = 5;
            efi.canTouchEfiVariables = true;
            timeout = 0;
        };
    };
}
