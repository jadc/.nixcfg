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
            programs.herdr = {
                enable = true;
                settings = {
                    onboarding = false;

                    theme.custom = {
                        accent = colors.base02.hex;
                        panel_bg = "transparent";
                        sidebar_bg = "transparent";
                        active_row_bg = colors.base01.hex;
                        selection_bg = colors.base01.hex;
                        surface0 = colors.base01.hex;
                        surface1 = colors.base02.hex;
                        surface_dim = colors.base01.hex;
                        overlay0 = colors.base03.hex;
                        overlay1 = colors.base04.hex;
                        text = colors.base05.hex;
                        subtext0 = colors.base04.hex;
                        mauve = colors.base0E.hex;
                        green = colors.base0B.hex;
                        yellow = colors.base0A.hex;
                        red = colors.base08.hex;
                        blue = colors.base0D.hex;
                        teal = colors.base0C.hex;
                        peach = colors.base09.hex;
                    };

                    # Keep new panes, tabs, and workspaces in the current path.
                    terminal.new_cwd = "follow";

                    ui = {
                        # Keep split lines matched with the sidebar border.
                        accent = colors.base01.hex;

                        # Retain tmux's mouse support.
                        mouse_capture = true;

                        # Keep the interface compact and tmux-like.
                        sidebar_start_collapsed = true;
                        sidebar_collapsed_mode = "hidden";
                        pane_gaps = false;
                        pane_outer_borders = false;
                        pane_scrollbars = true;
                        hide_tab_bar_when_single_tab = true;
                        show_agent_labels_on_pane_borders = false;
                    };

                    keys = {
                        settings = "prefix+shift+s";

                        # Split panes using similar keys to Vim.
                        split_vertical = "prefix+v";
                        split_horizontal = "prefix+s";

                        # Navigate panes using prefix/Alt+hjkl.
                        focus_pane_left = [ "prefix+h" "alt+h" ];
                        focus_pane_down = [ "prefix+j" "alt+j" ];
                        focus_pane_up = [ "prefix+k" "alt+k" ];
                        focus_pane_right = [ "prefix+l" "alt+l" ];

                        # Resize panes using Alt+Shift+hjkl.
                        resize_pane_left = "alt+shift+h";
                        resize_pane_down = "alt+shift+j";
                        resize_pane_up = "alt+shift+k";
                        resize_pane_right = "alt+shift+l";
                    };
                };
            };

            cfg.save.home.dirs = [ ".config/herdr" ];
        };
    };
}
