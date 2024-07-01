{ common, pkgs, ... }:

let shellAliases = common.aliases; in
{
    programs.zsh = {
        enable = true;
        inherit shellAliases;
        autosuggestion.enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;

        history = {
            expireDuplicatesFirst = true;   # Expire duplicate entries first when trimming history.
            extended = true;                # Write the history file in the ":start:elapsed;command" format.
            ignoreAllDups = true;           # Delete old recorded entry if new entry is a duplicate.
            ignoreDups = true;              # Don't record an entry that was just recorded again.
            share = true;                   # Share history between all sessions.
        };

        # Appended to end of ~/.zshrc
        initExtra = ''
            setopt BANG_HIST                # Treat the '!' character specially during expansion.
            setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits.
            setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry.
            setopt CSH_NULL_GLOB            # Delete pattern from argument list instead of reporting

            bindkey -v                      # Use vi keybindings

            # Prompt
            export PS1='%F{black}%1~%f %(!.%F{red}.%F{blue})$%f '

            # Neofetch knockoff
            fetch
        '';
    };

    # Backup shell
    programs.bash = {
        enable = true;
        inherit shellAliases;
        enableCompletion = true;
    };
}
