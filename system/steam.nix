# Steam: game library

{ config, ... }:

{
    programs.steam.enable = true;

    programs.gamemode = {
        enable = true;
        settings = {
            general.inhibit_screensaver = 0;
        };
    };
    users.users.${config.common.username}.extraGroups = [ "gamemode" ];
}
