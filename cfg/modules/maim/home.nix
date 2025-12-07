{ config, lib, pkgs, ...}:

let
    name = "maim";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [ maim xclip ];

        # Create keybinding
        services.sxhkd.keybindings = {
            "Print" = "${pkgs.maim}/bin/maim -s -u | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
        };
    };
}
