{ pkgs, ... }:

# Installs HP driver for proximity and gyroscopic sensors
{
    nixpkgs.overlays = [
        (final: prev: {
            linux-firmware = prev.linux-firmware.overrideAttrs (old: {
                postInstall = ''
                    cp ${./ishC_0207.bin} $out/lib/firmware/intel/ish/ish_lnlm_12128606.bin
                '';
            });
        })
    ];
    boot.kernelModules = [ "intel_ishtp_hid" ];
    hardware.firmware = [ pkgs.linux-firmware ];
    hardware.sensor.iio.enable = true;
}
