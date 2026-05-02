{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;

            size = lib.mkOption {
                type = lib.types.int;
                default = 1024;
                description = "Swapfile size in MB.";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            swapDevices = [ {
                device = if config.cfg.impermanence.enable then "/persist/swapfile" else "/var/lib/swapfile";
                size = self.size;
            } ];
        };
    };
}
