{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption "HP-specific drivers and firmware";
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            # Installs HP driver for proximity and gyroscopic sensors
            nixpkgs.overlays = [
                (final: prev: {
                    linux-firmware = prev.linux-firmware.overrideAttrs (old: {
                        postInstall = ''
                            cp ${./files/ishC_0207.bin} $out/lib/firmware/intel/ish/ish_lnlm_12128606.bin
                        '';
                    });
                })
            ];
            boot.kernelModules = [ "intel_ishtp_hid" ];
            hardware.firmware = [ pkgs.linux-firmware ];
            hardware.sensor.iio.enable = true;
        };
    };
}
