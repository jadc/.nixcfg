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
            programs.kitty = {
                enable = true;

                font = {
                    inherit (style.fonts.monospace) package name;
                    size = style.fonts.sizes.terminal;
                };

                settings = with style.colors; {
                    background = base00.hex;
                    foreground = base05.hex;
                    selection_background = base03.hex;
                    selection_foreground = base05.hex;
                    cursor = base05.hex;
                    cursor_text_color = base00.hex;
                    url_color = base04.hex;
                    active_border_color = base03.hex;
                    inactive_border_color = base01.hex;
                    wayland_titlebar_color = base00.hex;
                    macos_titlebar_color = base00.hex;
                    active_tab_background = base00.hex;
                    active_tab_foreground = base05.hex;
                    inactive_tab_background = base01.hex;
                    inactive_tab_foreground = base04.hex;
                    tab_bar_background = base01.hex;
                    color0 = base00.hex;
                    color1 = base08.hex;
                    color2 = base0B.hex;
                    color3 = base0A.hex;
                    color4 = base0D.hex;
                    color5 = base0E.hex;
                    color6 = base0C.hex;
                    color7 = base05.hex;
                    color8 = base02.hex;
                    color9 = base08.hex;
                    color10 = base0B.hex;
                    color11 = base0A.hex;
                    color12 = base0D.hex;
                    color13 = base0E.hex;
                    color14 = base0C.hex;
                    color15 = base07.hex;
                    color16 = base09.hex;
                    color17 = base0F.hex;
                    color18 = base01.hex;
                    color19 = base02.hex;
                    color20 = base04.hex;
                    color21 = base06.hex;

                    background_opacity = toString style.opacity.terminal;
                    copy_on_select = "clipboard";
                    confirm_os_window_close = 0;
                    enable_audio_bell = false;
                    resize_in_steps = false;
                    update_check_interval = 0;
                    window_padding_width = 24;
                };

                keybindings = {
                    "kitty_mod+equal" = "change_font_size all +1.0";
                    "kitty_mod+minus" = "change_font_size all -1.0";
                    "f11" = "toggle_fullscreen";

                    # Use only system clipboard
                    "ctrl+shift+s" = "no_op";
                    "shift+insert" = "paste_from_clipboard";
                };

                mouseBindings = {
                    "middle release ungrabbed" = "paste_from_clipboard";
                };


                extraConfig = ''
                    kitty_mod ctrl+alt
                '';
            };

            home.sessionVariables.TERMINAL = "kitty";

            # Correct aliases to use kitty
            cfg.const.aliases.ssh = "TERM=xterm-256color ${pkgs.openssh}/bin/ssh";
        };
    };
}
