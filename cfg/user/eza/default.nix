# eza: ls replacement

{ config, lib, pkgs, ... }:

let
    name = "eza";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.eza.enable = true;

        # Replace ls with eza
        common.aliases.ls = "${pkgs.eza}/bin/eza --icons=always $@";
    };
}
