{ config, lib, pkgs, ...}:

let
    name = "rofi";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.rofi = {
            enable = true;
            #font = "";
            theme = "Arc-Dark";
        };

        # Create keybinding
        services.sxhkd.keybindings = {
            "super + @space" = "${pkgs.rofi}/bin/rofi -show drun -show-icons";
        };
    };
}
