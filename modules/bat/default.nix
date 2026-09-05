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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let
        self = config.cfg.${name};
        theme = pkgs.replaceVars ./theme.tmTheme (removeAttrs
            (lib.mapAttrs (_: color: color.hex) config.cfg.style.colors)
            [ "base04" "base06" ]);
    in {
        config = lib.mkIf self.enable {
            programs.bat = {
                enable = true;
                themes.style.src = theme;
                config = {
                    theme = "style";
                    # Use italic text in syntax highlighting
                    italic-text = "always";
                    # Don't page long output
                    paging = "never";
                    # Remove decorations
                    style = "plain";
                };
            };
            cfg.const.aliases.cat = "${pkgs.bat}/bin/bat";
        };
    };
}
