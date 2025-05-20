{ pkgs, ... }:

{
    home.packages = with pkgs; [ gdb ];
    common.aliases.gdb = "${pkgs.gdb}/bin/gdb --tui $@";
}
