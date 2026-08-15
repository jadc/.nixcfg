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

    flake.modules.nixos.${name} = { config, lib, username, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs = {
                gamemode = {
                    enable = true;
                    settings.general = {
                        inhibit_screensaver = 0;
                        renice = 10;
                        ioprio = 0;
                    };
                };

                gamescope = {
                    enable = true;
                    capSysNice = true;
                };
            };

            users.users.${username}.extraGroups = [ "gamemode" ];
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [
                (pkgs.writeShellApplication {
                    name = "gamerun";
                    runtimeInputs = [ pkgs.gamemode ];
                    text = builtins.readFile ./gamerun.sh;
                })
            ];
        };
    };
}
