# Enables Mosh server

{ config, lib, ... }:

let
    name = "moshserver";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.mosh.enable = true;
    };
}
