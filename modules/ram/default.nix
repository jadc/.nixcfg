{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            swapfileSize = lib.mkOption {
                type = lib.types.int;
                default = 0;
                description = "Swapfile size in MB.";
            };

            zramPercent = lib.mkOption {
                type = lib.types.int;
                default = 0;
                description = "Percentage of RAM to use for zram swap.";
            };

            oomThreshold = lib.mkOption {
                type = lib.types.int;
                default = 0;
                description = "Free memory/swap percentage at which earlyoom kills processes.";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkMerge [
            (lib.mkIf (self.swapfileSize > 0) {
                swapDevices = [
                    {
                        device = if config.cfg.save.enable
                                 then "${config.cfg.save.path}/swapfile"
                                 else "/var/lib/swapfile";
                        size = self.swapfileSize;
                    }
                ];
            })

            (lib.mkIf (self.zramPercent > 0) {
                zramSwap = {
                    enable = true;
                    memoryPercent = self.zramPercent;
                };
            })

            (lib.mkIf (self.oomThreshold > 0) {
                services.earlyoom = {
                    enable = true;
                    freeMemThreshold = self.oomThreshold;
                    freeSwapThreshold = self.oomThreshold;
                };
            })
        ];
    };
}
