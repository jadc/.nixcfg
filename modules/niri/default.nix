{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
            extraConfig = lib.mkOption {
                type = lib.types.lines;
                default = "";
                description = "Extra KDL config appended to niri config";
            };
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, username, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.niri.enable = true;

            # Required for file pickers, screen sharing, and screenshots
            xdg.portal = {
                enable = true;
                extraPortals = [ pkgs.xdg-desktop-portal-gnome ];
            };

            # Login manager
            services.greetd = {
                enable = true;
                settings = {
                    # Auto-login
                    default_session.command = "${pkgs.greetd}/bin/agreety --cmd niri-session";
                    initial_session = {
                        command = "niri-session";
                        user = username;
                    };
                };
            };
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = with pkgs; [
                xwayland-satellite
                wl-clipboard
                brightnessctl
                playerctl
                grim
                slurp
            ];

            xdg.configFile."niri/config.kdl".text =
                builtins.readFile ./config.kdl + self.extraConfig;
        };
    };
}
