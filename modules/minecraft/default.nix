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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }:
    let
        self = config.cfg.${name};
    in {
        config = lib.mkIf self.enable {
            home.packages = [
                (pkgs.prismlauncher.override {
                    jdks = [
                        pkgs.temurin-bin-8
                        pkgs.temurin-bin-17
                        pkgs.temurin-bin
                    ];
                })
            ];

            home.sessionVariables = {
                _JAVA_AWT_WM_NONREPARENTING = 1;
            };

            cfg.save.home.dirs = [
                ".local/share/PrismLauncher"
                ".minecraft"
            ];
        };
    };
}
