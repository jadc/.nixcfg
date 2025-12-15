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
                buffer_font_family = "JetBrainsMono Nerd Font";
                ui_font_size = 16.0;
                buffer_font_size = 16.0;
                buffer_font_weight = 400.0;

                show_wrap_guides = true;
                soft_wrap = "editor_width";
                git = {
                    hunk_style = "unstaged_hollow";
                    inline_blame.show_commit_summary = true;
                };
                collaboration_panel.button = false;
                notification_panel.button = false;
                preview_tabs = {
                    enabled = false;
                    enable_preview_from_file_finder = false;
                };
                tabs = {
                    file_icons = true;
                    git_status = true;
                };
                close_on_file_delete = true;
                search.center_on_match = true;
                use_smartcase_search = true;
                prettier.allowed = true;
                colorize_brackets = true;
                inlay_hints = {
                    enabled = true;
                    show_background = false;
                };
                show_whitespaces = "trailing";
                use_auto_surround = false;
                use_autoclose = false;
                ensure_final_newline_on_save = false;
                remove_trailing_whitespace_on_save = false;
                format_on_save = "off";

                minimap = {
                    thumb_border = "none";
                    max_width_columns = 32;
                    show = "always";
                };
                project_panel.scrollbar.show = "never";

                relative_line_numbers = "enabled";
                auto_signature_help = true;
                auto_update = false;
                telemetry = {
                    diagnostics = false;
                    metrics = false;
                };
                title_bar = {
                    show_menus = false;
                    show_onboarding_banner = false;
                    show_branch_name = true;
                    show_branch_icon = true;
                    show_sign_in = false;
                };
                theme = "One Black";
                vim_mode = true;
                terminal = {
                    toolbar.breadcrumbs = false;
                    dock = "right";
                    font_size = 14.0;
                };
                auto_install_extensions = {
                    assembly = true;
                    basher = true;
                    csharp = true;
                    discord-presence = true;
                    dockerfile = true;
                    html = true;
                    java = true;
                    latex = true;
                    lua = true;
                    neocmake = true;
                    nix = true;
                    one-black-theme = true;
                    sql = true;
                    toml = true;
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
