{ pkgs, ...}:

{
    home.packages = with pkgs; [ ulauncher ];

    # Create keybinding
    services.sxhkd.keybindings = {
        "super + @space" = "${pkgs.ulauncher}/bin/ulauncher";
    };
}
