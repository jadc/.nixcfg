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
    in {
        config = lib.mkIf self.enable {
            programs.kitty = {
                enable = true;

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

                settings = {
                    background_opacity = lib.mkForce (toString config.cfg.style.opacity.terminal);
                    copy_on_select = "clipboard";
                    confirm_os_window_close = 0;
                    enable_audio_bell = false;
                    resize_in_steps = false;
                    update_check_interval = 0;
                    wayland_titlebar_color = "black";
                    window_padding_width = 24;
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
