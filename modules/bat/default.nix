{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
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
    };
}
