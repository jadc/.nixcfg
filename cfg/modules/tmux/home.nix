{ config, lib, pkgs, ... }:

let
    name = "tmux";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.tmux = {
            enable = true;

            # window indices start at 1
            baseIndex = 1;

            # mouse support
            mouse = true;

            # enable vi mode keys
            keyMode = "vi";

            # remove delay on escape key
            escapeTime = 0;

            # fix colors
            terminal = "tmux-256color";

            # adds bind (y) to copy to system clipboard
            plugins = with pkgs; [ tmuxPlugins.yank ];

            extraConfig = ''
                # split panes using | and -, in the current path
                bind \\ split-window -h -c "#{pane_current_path}"
                bind - split-window -v -c "#{pane_current_path}"
                unbind '"'
                unbind %

                # open new windows in the current path
                bind c new-window -c "#{pane_current_path}"

                # vim-tmux-navigator: detect if pane is running vim
                is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?|fzf)(diff)?$'"

                # switch panes using Alt+hjkl (pass through to vim if in vim)
                bind -n M-h if-shell "$is_vim" 'send-keys M-h' 'select-pane -L'
                bind -n M-j if-shell "$is_vim" 'send-keys M-j' 'select-pane -D'
                bind -n M-k if-shell "$is_vim" 'send-keys M-k' 'select-pane -U'
                bind -n M-l if-shell "$is_vim" 'send-keys M-l' 'select-pane -R'

                # resize panes using Alt+Shift+hjkl (pass through to vim if in vim)
                bind -n M-H if-shell "$is_vim" 'send-keys M-H' 'resize-pane -L 5'
                bind -n M-J if-shell "$is_vim" 'send-keys M-J' 'resize-pane -D 5'
                bind -n M-K if-shell "$is_vim" 'send-keys M-K' 'resize-pane -U 5'
                bind -n M-L if-shell "$is_vim" 'send-keys M-L' 'resize-pane -R 5'

                # hide status bar
                set -g status off

                # fix colors
                set -sg terminal-overrides ",*:RGB"
            '';
        };
    };
}
