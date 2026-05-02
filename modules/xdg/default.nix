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

    flake.modules.homeManager.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            xdg = {
                enable = true;
                userDirs = {
                    enable = true;
                    createDirectories = true;

                    # Disable undesired directories
                    desktop = null;
                    projects = null;
                    publicShare = null;
                    templates = null;
                };
            };
        };
    };
}
