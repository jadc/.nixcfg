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
        colors = config.cfg.style.colors;
    in {
        config = lib.mkIf self.enable {
            programs.btop = {
                enable = true;
                settings = {
                    color_theme = "style";
                    theme_background = false;
                };
                themes.style = with colors; ''
                    theme[main_bg]="${base00.hex}"
                    theme[main_fg]="${base05.hex}"
                    theme[title]="${base05.hex}"
                    theme[hi_fg]="${base0D.hex}"
                    theme[selected_bg]="${base03.hex}"
                    theme[selected_fg]="${base0D.hex}"
                    theme[inactive_fg]="${base04.hex}"
                    theme[graph_text]="${base06.hex}"
                    theme[meter_bg]="${base03.hex}"
                    theme[proc_misc]="${base06.hex}"
                    theme[cpu_box]="${base0E.hex}"
                    theme[mem_box]="${base0B.hex}"
                    theme[net_box]="${base0C.hex}"
                    theme[proc_box]="${base0D.hex}"
                    theme[div_line]="${base01.hex}"
                    theme[temp_start]="${base0B.hex}"
                    theme[temp_mid]="${base0A.hex}"
                    theme[temp_end]="${base08.hex}"
                    theme[cpu_start]="${base0B.hex}"
                    theme[cpu_mid]="${base0A.hex}"
                    theme[cpu_end]="${base08.hex}"
                    theme[free_start]="${base0A.hex}"
                    theme[free_mid]="${base0B.hex}"
                    theme[free_end]="${base0B.hex}"
                    theme[cached_start]="${base0C.hex}"
                    theme[cached_mid]="${base0C.hex}"
                    theme[cached_end]="${base0A.hex}"
                    theme[available_start]="${base08.hex}"
                    theme[available_mid]="${base0A.hex}"
                    theme[available_end]="${base0B.hex}"
                    theme[used_start]="${base0A.hex}"
                    theme[used_mid]="${base09.hex}"
                    theme[used_end]="${base08.hex}"
                    theme[download_start]="${base0B.hex}"
                    theme[download_mid]="${base0A.hex}"
                    theme[download_end]="${base08.hex}"
                    theme[upload_start]="${base0B.hex}"
                    theme[upload_mid]="${base0A.hex}"
                    theme[upload_end]="${base08.hex}"
                    theme[process_start]="${base0B.hex}"
                    theme[process_mid]="${base0A.hex}"
                    theme[process_end]="${base08.hex}"
                '';
            };

            home.packages = [ pkgs.killall ];

            cfg.const.aliases = let
                topclient = "${pkgs.btop}/bin/btop";
            in {
                btop = topclient;
                htop = topclient;
                top = topclient;
            };
        };
    };
}
