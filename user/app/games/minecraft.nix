# minecraft (via prismlauncher) and java runtime

{ pkgs, ... }:

{
    # TODO: use wrapProgram to install jre8 as well without conflicting
    home.packages = with pkgs; [ prismlauncher jre_minimal ];
    home.sessionVariables = {
        _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";
        _JAVA_AWT_WM_NONREPARENTING = 1;
    };
}
