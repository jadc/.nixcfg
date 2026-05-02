{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
            off = lib.mkOption {
                type = lib.types.bool;
                default = false;
                description = "Disable all RGB lighting";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            services.hardware.openrgb.enable = true;
            services.udev.packages = [ pkgs.openrgb ];
            boot.kernelModules = [ "i2c-dev" "i2c-i801" "i2c-piix4" ];
            hardware.i2c.enable = true;

            systemd.services.no-rgb = lib.mkIf self.off {
                description = "no-rgb";
                serviceConfig = {
                    ExecStart = "-${pkgs.openrgb}/bin/openrgb --noautoconnect --mode static --color 000000";
                    Type = "simple";
                    RemainAfterExit = true;
                };
                wantedBy = [ "multi-user.target" ];
            };
        };
    };
}
