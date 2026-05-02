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
            programs.steam.enable = true;

            programs.gamemode = {
                enable = true;
                settings = {
                    general.inhibit_screensaver = 0;
                };
            };
            users.users.${username}.extraGroups = [ "gamemode" ];
        };
    };
}
