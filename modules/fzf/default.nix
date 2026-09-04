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

    flake.modules.homeManager.${name} = { config, lib, ... }: let
        self = config.cfg.${name};
        colors = config.cfg.style.colors;
    in {
        config = lib.mkIf self.enable {
            stylix.targets.fzf.enable = false;

            programs.fzf = {
                enable = true;
                colors = {
                    "bg" = colors.base00.hex;
                    "bg+" = colors.base01.hex;
                    "fg" = colors.base04.hex;
                    "fg+" = colors.base06.hex;
                    "header" = colors.base0D.hex;
                    "hl" = colors.base0D.hex;
                    "hl+" = colors.base0D.hex;
                    "info" = colors.base0A.hex;
                    "marker" = colors.base0C.hex;
                    "pointer" = colors.base0C.hex;
                    "prompt" = colors.base0A.hex;
                    "spinner" = colors.base0C.hex;
                };
            };
        };
    };
}
