{ config, lib, pkgs, ... }:

let
    name = "bat";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

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
        common.aliases.cat = "${pkgs.bat}/bin/bat";
    };
}
