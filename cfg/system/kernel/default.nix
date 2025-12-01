{ config, pkgs, lib, ... }:

let
    name = "kernel";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;

        build = mkOption {
            type = raw;
            default = pkgs.linuxPackages_latest;
        };

        flags = {
            quiet = mkOption {
                type = types.bool;
                default = false;
            };

            performance = mkOption {
                type = types.bool;
                default = false;
            };

            intel = mkOption {
                type = types.bool;
                default = false;
            };
        };
    };

    config = with lib; mkIf self.enable {
        boot = {
            kernelPackages = self.build;
            kernelParams =
                optionals self.flags.quiet [
                    "acpi_osi=Linux"
                    "loglevel=3"
                    "quiet"
                    "rd.systemd.show_status=auto"
                    "rd.udev.log_level=3"
                ] ++ optionals self.flags.performance [
                    "nowatchdog"
                    "nomce"
                    "mitigations=off"
                    "random.trust_cpu=on"
                    "fsck.mode=skip"
                    "libahci.ignore_sss=1"
                ] ++ optionals self.flags.intel [
                    "i915.enable_fbc=1"
                    "i915.fastboot=1"
                    "i915.modeset=1"
                ];
        };
    };
}
