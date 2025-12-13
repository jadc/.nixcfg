{ config, lib, pkgs, ... }:

let
    name = "rgb";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
        off = mkOption {
            type = types.bool;
            default = false;
            description = "Disable all RGB lighting";
        };
    };

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
}
