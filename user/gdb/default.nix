{ pkgs, ... }:

{
    home.packages = with pkgs; [ gdb ];
    common.aliases.gdb = "${pkgs.gdb}/bin/gdb --tui --args $@";

    # Disable path security check
    home.file.".gdbinit".text = "set auto-load safe-path /";
}
