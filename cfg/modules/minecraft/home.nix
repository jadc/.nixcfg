{ config, lib, pkgs, ... }:

let
    name = "minecraft";
    self = config.cfg.user.${name};
    alternative = with pkgs; [ jdk8 jdk ];
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

            # Default java is 17
            package = pkgs.jdk17;
        };

        # Alternative java versions
        home.file = (builtins.listToAttrs (builtins.map (jdk: {
            name = ".jdks/${jdk.version}";
            value = { source = jdk; };
        }) alternative));

        home.sessionVariables = {
            _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
            _JAVA_AWT_WM_NONREPARENTING = 1;
        };
    };
}
