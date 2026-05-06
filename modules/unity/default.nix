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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.unityhub ];

            cfg.impermanence.home.dirs = [
                ".config/unity3d"
                ".config/UnityHub"
                ".local/share/unity3d"
            ];
        };
    };
}
