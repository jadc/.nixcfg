# eza: ls replacement

{ pkgs, lib, ... }:

{
    programs.eza.enable = true;

    # Replace ls with eza
    common.aliases.ls = lib.mkForce "${pkgs.eza}/bin/eza --icons";
}
