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
            home.packages = [ pkgs.hunk ];
            xdg.configFile."hunk/config.toml".source = ./config.toml;

            # Install Hunk skill in Pi.
            home.file.".pi/agent/skills/hunk-review".source = "${pkgs.hunk}/skills/hunk-review";
        };
    };
}
