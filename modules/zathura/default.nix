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
        style = config.cfg.style;
    in {
        config = lib.mkIf self.enable {
            programs.zathura = {
                enable = true;
                options = with style.colors; lib.mapAttrs (_: lib.mkForce) {
                    default-bg = base00.rgba style.opacity.applications;
                    default-fg = base01.rgb;
                    statusbar-fg = base04.rgb;
                    statusbar-bg = base02.rgb;
                    inputbar-bg = base00.rgb;
                    inputbar-fg = base07.rgb;
                    notification-bg = base00.rgb;
                    notification-fg = base07.rgb;
                    notification-error-bg = base00.rgb;
                    notification-error-fg = base08.rgb;
                    notification-warning-bg = base00.rgb;
                    notification-warning-fg = base08.rgb;
                    highlight-color = base0A.rgba 0.5;
                    highlight-active-color = base0D.rgba 0.5;
                    completion-bg = base01.rgb;
                    completion-fg = base0D.rgb;
                    completion-highlight-fg = base07.rgb;
                    completion-highlight-bg = base0D.rgb;
                    recolor-lightcolor = base00.rgb;
                    recolor-darkcolor = base06.rgb;
                };
                mappings = {
                    "<C-r>" = "recolor";
                };
            };

            xdg.mimeApps = lib.mkIf pkgs.stdenv.hostPlatform.isLinux {
                enable = true;
                defaultApplications = {
                    "application/pdf" = "org.pwmt.zathura.desktop";
                };
            };
        };
    };
}
