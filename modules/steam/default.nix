{ config, lib, username, ... }:

let
    name = "steam";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

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
}
