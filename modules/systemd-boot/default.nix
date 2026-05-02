{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            boot.loader = {
                systemd-boot.enable = true;
                systemd-boot.configurationLimit = 5;
                efi.canTouchEfiVariables = true;
                timeout = 0;
            };
        };
    };
}
