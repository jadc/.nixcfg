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
                    default_session.command = lib.escapeShellArgs (
                        [ config.cfg.greeter.command ]
                        ++ config.cfg.greeter.extraArgs
                        ++ [ "--cmd" "niri-session" ]
                    );
                };
            };

            hardware.i2c.enable = true;

            users.users.${username}.extraGroups = [ "i2c" ];
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = with pkgs; [
                xwayland-satellite
                wl-clipboard
                playerctl
                grim
                slurp
                ddcutil
                brightnessctl
            ];

            programs.noctalia.settings.brightness.enable_ddcutil = true;

            # Retain CLIPBOARD data after the application that supplied it exits.
            services.wl-clip-persist = {
                enable = true;
                clipboardType = "regular";
            };

            xdg.configFile."niri/config.kdl".text =
                builtins.readFile ./config.kdl + self.extraConfig;
        };
    };
}
