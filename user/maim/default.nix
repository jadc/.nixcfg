{ pkgs, ...}:

{
    home.packages = with pkgs; [ maim xclip ];

    # Create keybinding
    services.sxhkd.keybindings = {
        "Print" = "${pkgs.maim}/bin/maim -s -u | ${pkgs.xclip}/bin/xclip -selection clipboard -t image/png";
    };
}
