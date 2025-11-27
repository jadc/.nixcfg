{ config, lib, ... }:

let
    name = "intel";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        hardware.cpu.intel.updateMicrocode = true;
    };
}
