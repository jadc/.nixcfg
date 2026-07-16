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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let
        self = config.cfg.${name};
        dirs = lib.filter builtins.isString (builtins.attrValues config.xdg.userDirs);
    in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.nautilus ];

            home.file.".config/gtk-3.0/bookmarks".text = lib.concatMapStringsSep "\n" (dir: "file://${dir}") dirs + "\n";
        };
    };
}
