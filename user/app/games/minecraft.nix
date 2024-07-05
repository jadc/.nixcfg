# minecraft (via prismlauncher) and java runtime

{ pkgs, ... }:

let
    alternative = with pkgs; [ jdk8 jdk17 ];
in
{
    home.packages = with pkgs; [ prismlauncher ];

    # Java
    programs.java = {
        enable = true;
        
        # Default java is latest
        package = pkgs.jdk;
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
}
