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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ...}: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.maim pkgs.xclip ];

            # Create keybinding
            services.sxhkd.keybindings = {
                "Print" = "${pkgs.maim}/bin/maim -s -u | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
            };
        };
    };
}
