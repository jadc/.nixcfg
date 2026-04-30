{ config, lib, pkgs, ...}:

let
    name = "maim";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        home.packages = [ pkgs.maim pkgs.xclip ];

        # Create keybinding
        services.sxhkd.keybindings = {
            "Print" = "${pkgs.maim}/bin/maim -s -u | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
        };
    };
}
