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
            programs.gamemode = {
                enable = true;
                settings = {
                    general.inhibit_screensaver = 0;
                    gpu = {
                        apply_gpu_optimisations = "accept-responsibility";
                        gpu_device = 0;
                    };
                    custom = {
                        start = "notify-send 'GameMode' 'Started'";
                        end = "notify-send 'GameMode' 'Stopped'";
                    };
                };
            };
            users.users.${username}.extraGroups = [ "gamemode" ];
        };
    };
}
