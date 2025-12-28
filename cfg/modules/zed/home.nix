{ config, lib, pkgs, ... }:

let
    name = "zed";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
        server = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = lib.mkIf self.enable {
        programs.zed-editor = {
            enable = true;

            extensions = [
                "assembly"
                "basher"
                "csharp"
                "discord-presence"
                "dockerfile"
                "html"
                "java"
                "latex"
                "lua"
                "neocmake"
                "nix"
                "one-black-theme"
                "sql"
                "toml"
            ];

            userSettings = {
                vim_mode = true;

                # Font size and family
                buffer_font_family = "JetBrainsMono Nerd Font";
                buffer_font_size = 16.0;
                buffer_font_weight = 400.0;
                ui_font_size = 16.0;

                # Theme
                theme = "One Black";
                theme_overrides."One Black" = {
                    "tab.active_background" = "#262626ff";
                    "tab.inactive_background" = "#030303ff";
                    "tab_bar.background" = "#030303ff";
                    syntax = {
                        "comment".font_style = "italic";
                        "comment.doc".font_style = "italic";
                    };
                };

                # Editor
                auto_signature_help = true;
                colorize_brackets = true;
                indent_guides = {
                    enabled = true;
                    coloring = "indent_aware";
                };
                inlay_hints = {
                    enabled = true;
                    show_background = true;
                };
                diagnostics.inline.enabled = true;
                show_whitespaces = "trailing";
                soft_wrap = "editor_width";
                show_wrap_guides = true;
                wrap_guides = [ 80 ];

                # UI/UX
                collaboration_panel.button = false;
                notification_panel.button = false;
                title_bar = {
                    show_branch_icon = true;
                    show_menus = false;
                    show_onboarding_banner = false;
                    show_sign_in = false;
                    show_user_picture = false;
                };
                terminal = {
                    dock = "right";
                    font_size = 14.0;
                };
                preview_tabs = {
                  enabled = true;
                  enable_preview_multibuffer_from_code_navigation = true;
                };
                project_panel.hide_root = true;

                # Tabs
                tab_size = 4;
                tabs = {
                    file_icons = true;
                    git_status = true;
                };
                close_on_file_delete = true;

                # Search and Navigation
                search.center_on_match = true;
                use_smartcase_search = true;
                double_click_in_multibuffer = "open";

                # Disable auto-formatting
                ensure_final_newline_on_save = false;
                format_on_save = "off";
                remove_trailing_whitespace_on_save = false;

                # Meta
                auto_update = false;
                telemetry = {
                    diagnostics = false;
                    metrics = false;
                };
            };

            userKeymaps = [
                {
                    bindings = {
                        "ctrl-h" = "vim::GoToPreviousTab";
                        "ctrl-l" = "vim::GoToTab";
                        "ctrl-w" = "pane::CloseActiveItem";
                    };

                    context = "((VimControl && !menu) || (!Editor && !Terminal))";
                }
            ];

            # Allow the current machine to remotable by Zed
            installRemoteServer = self.server;

            # Appears only nil cannot be installed by Zed itself
            extraPackages = with pkgs; [ nil ];
        };
    };
}
