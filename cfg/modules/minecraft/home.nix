{ config, lib, pkgs, ... }:

let
    name = "minecraft";
    self = config.cfg.user.${name};
    alternative = with pkgs; [ jdk8 jdk17 ];
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        home.packages = with pkgs; [ prismlauncher ];

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
}
