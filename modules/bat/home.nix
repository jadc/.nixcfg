{ config, lib, pkgs, ... }:

let
    name = "bat";
    self = config.cfg.${name};
in
{
    imports = [ ./options.nix ];

    config = lib.mkIf self.enable {
        programs.bat = {
            enable = true;
            config = {
                # Use italic text in syntax highlighting
                italic-text = "always";
                # Don't page long output
                paging = "never";
                # Remove decorations
                style = "plain";
                # Syntax highlighting theme
                theme = "OneHalfDark";
            };
        };
        cfg.const.aliases.cat = "${pkgs.bat}/bin/bat";
    };
}
