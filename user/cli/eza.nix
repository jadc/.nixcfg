# eza: ls replacement

{ pkgs, ... }:

{
    programs.eza.enable = true;

    # Replace ls with eza
    common.aliases.ls = "${pkgs.eza}/bin/eza --icons";
}
