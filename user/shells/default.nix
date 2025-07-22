{ config, ... }:

{
    imports = [ ./alias.nix ];
    programs.zsh = {
        enable = true;
        shellAliases = config.common.aliases;
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
        initContent = let
                C = "\\e[1;34m";
                G = "\\e[1;33m";
                B = "\\e[0;30m";
                NC = "\\e[0m";
            in ''
            setopt BANG_HIST                # Treat the '!' character specially during expansion.
            setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits.
            setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry.
            setopt CSH_NULL_GLOB            # Delete pattern from argument list instead of reporting

            bindkey -v                      # Use vi keybindings

            # Prompt
            export PS1='%F{black}%1~%f %(!.%F{red}.%F{blue})$%f '

            # Neofetch knockoff
            i=$(cat /proc/uptime | awk -F'.' '{print $1}')
            ((i/=60, min=i%60, hrs=i/60))
            echo "${B} ,o()()o,  ${C}$USER${NC}"
            echo "${B},o'    'o,  ${C}dt${NC}  $(date '+%b. %d' | awk '{print tolower($0)}')"
            echo "${B}'O ${G}.  .${B} O'  ${C}up${NC}  $(printf "%dh %02dm" $hrs $min)"
            echo "${B}  ·____·"
            echo ""
        '';
    };
}
