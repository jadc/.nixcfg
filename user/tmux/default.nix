{ pkgs, ... }:

{
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

            # switch panes using Alt-arrow without prefix
            bind -n M-h select-pane -L
            bind -n M-l select-pane -R
            bind -n M-j select-pane -U
            bind -n M-k select-pane -D

            # resize panes using Alt-shift-arrow without prefix
            bind -n -r M-H resize-pane -L 5
            bind -n -r M-L resize-pane -R 5
            bind -n -r M-J resize-pane -D 5
            bind -n -r M-K resize-pane -U 5

            # hide status bar
            set -g status off

            # fix colors
            set -sg terminal-overrides ",*:RGB"
        '';
    };
}
