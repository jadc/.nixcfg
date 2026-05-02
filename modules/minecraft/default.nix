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
        alternative = [ pkgs.jdk8 pkgs.jdk17 ];
    in {
        config = lib.mkIf self.enable {
            home.packages = [ pkgs.prismlauncher ];

            # Java
            programs.java = {
                enable = true;

                # Default java is latest
                package = pkgs.jdk;
            };

            # Alternative java versions
            home.file = (builtins.listToAttrs (map (jdk: {
                name = ".jdks/${jdk.version}";
                value = { source = jdk; };
            }) alternative));

            home.sessionVariables = {
                _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
                _JAVA_AWT_WM_NONREPARENTING = 1;
            };
        };
    };
}
