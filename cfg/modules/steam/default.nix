# Steam: game library

{ config, lib, ... }:

let
    name = "steam";
    self = config.cfg.system.${name};
in
{
    options.cfg.system.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.steam.enable = true;

        programs.gamemode = {
            enable = true;
            settings = {
                general.inhibit_screensaver = 0;
            };
        };
        users.users.${config.cfg.const.username}.extraGroups = [ "gamemode" ];
    };
}
