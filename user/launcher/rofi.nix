{ config, pkgs, ...}:

{
    programs.rofi = {
        enable = true;
        #font = "";
        theme = "Arc-Dark";
    };

    # Create keybinding
    services.sxhkd.keybindings = {
        "super + @space" = "${pkgs.rofi}/bin/rofi -show drun -show-icons";
    };
}
