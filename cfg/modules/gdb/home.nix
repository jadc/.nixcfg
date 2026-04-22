{ config, lib, pkgs, ... }:

let
    name = "gdb";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.gdb ];
        cfg.const.aliases.gdb = "${pkgs.gdb}/bin/gdb --tui --args $@";

        # Disable path security check
        home.file.".gdbinit".text = "set auto-load safe-path /";
    };
}
