{ pkgs, ... }:

let
    shellAliases = {
        # Default flags
        sudo="sudo -E";
        du="du -h";
        cp="cp -ivp";
        mv="mv -iv";
        mkdir="mkdir -pv";
        make="make -j$(nproc)";
        rsync="rsync -avhP --no-compress";

        ## Colors
        ls="ls -hN --color=auto --group-directories-first";
        grep="grep --color=auto";
        fgrep="fgrep --color=auto";
        egrep="egrep --color=auto";
        diff="diff --color=auto";

        # Shortcuts
        wavtoflac="flac --best --delete-input-file -e -p -V -f --keep-foreign-metadata *.wav";
        texview="latexmk -pdf -pvc *.tex";
    };
in
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
