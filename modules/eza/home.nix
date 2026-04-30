{ config, lib, pkgs, ... }:

let
    name = "eza";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.eza.enable = true;

        # Replace ls with eza
        cfg.const.aliases.ls = "${pkgs.eza}/bin/eza --icons=always $@";
    };
}
