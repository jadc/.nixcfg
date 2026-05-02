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
            boot.kernelModules = [ "i2c-dev" ];
            hardware.i2c.enable = true;

            systemd.services.no-rgb = lib.mkIf self.off {
                description = "no-rgb";
                serviceConfig = let
                    no-rgb = pkgs.writeScriptBin "no-rgb" ''
                        #!/bin/sh
                        NUM_DEVICES=$(${pkgs.openrgb}/bin/openrgb --noautoconnect --list-devices | grep -E '^[0-9]+: ' | wc -l)

                        for i in $(seq 0 $(($NUM_DEVICES - 1))); do
                            ${pkgs.openrgb}/bin/openrgb --noautoconnect --device $i --mode static --color 000000
                        done
                    '';
                in {
                    ExecStart = "${no-rgb}/bin/no-rgb";
                    Type = "oneshot";
                };
                wantedBy = [ "multi-user.target" ];
            };
        };
    };
}
