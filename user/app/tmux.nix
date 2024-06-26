{
    programs.tmux = {
        enable = true;

        # mouse support
        mouse = true;

        # enable vi mode keys
        keyMode = "vi";

        # remove delay on escape key
        escapeTime = 0;

        # fix colors
        terminal = "tmux-256color";

        extraConfig = ''
            # split panes using | and -, in the current path
            bind \\ split-window -h -c "#{pane_current_path}"
            bind - split-window -v -c "#{pane_current_path}"
            unbind '"'
            unbind %

            # open new windows in the current path
            bind c new-window -c "#{pane_current_path}"

            # start with window and pane 1
            set -g base-index 1
            set -g pane-base-index 1

            # switch panes using Alt-arrow without prefix
            bind -n M-h select-pane -L
            bind -n M-l select-pane -R
            bind -n M-j select-pane -U
            bind -n M-k select-pane -D

            # hide status bar
            set -g status off

            # fix colors
            set -sg terminal-overrides ",*:RGB"
        '';
    };
}
