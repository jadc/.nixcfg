{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.gdb ];
            cfg.const.aliases.gdb = "${pkgs.gdb}/bin/gdb --tui --args $@";

            # Disable path security check
            home.file.".gdbinit".text = "set auto-load safe-path /";
        };
    };
}
