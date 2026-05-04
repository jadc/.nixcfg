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

    flake.modules.homeManager.${name} = { config, lib, ... }: let
        self = config.cfg.${name};
    in {
        config = lib.mkIf self.enable {
            programs.swaylock = {
                enable = true;
                settings = {
                    indicator-radius = 100;
                    indicator-thickness = 10;
                };
            };
            home.sessionVariables.LOCKER = "swaylock";
        };
    };
}
