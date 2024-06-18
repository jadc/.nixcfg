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

        # Fetch
        envExtra = '''';

        /*
        setOptions = [
            "BANG_HIST"                 # Treat the '!' character specially during expansion.
            "EXTENDED_HISTORY"          # Write the history file in the ":start:elapsed;command" format.
            "INC_APPEND_HISTORY"        # Write to the history file immediately, not when the shell exits.
            "SHARE_HISTORY"             # Share history between all sessions.
            "HIST_EXPIRE_DUPS_FIRST"    # Expire duplicate entries first when trimming history.
            "HIST_IGNORE_DUPS"          # Don't record an entry that was just recorded again.
            "HIST_IGNORE_ALL_DUPS"      # Delete old recorded entry if new entry is a duplicate.
            "HIST_FIND_NO_DUPS"         # Do not display a line previously found.
            "HIST_IGNORE_SPACE"         # Don't record an entry starting with a space.
            "HIST_SAVE_NO_DUPS"         # Don't write duplicate entries in the history file.
            "HIST_REDUCE_BLANKS"        # Remove superfluous blanks before recording entry.
            "CSH_NULL_GLOB"             # Delete pattern from argument list instead of reporting
        ];
        */
    };

    # Backup shell
    programs.bash = {
        enable = true;
        inherit shellAliases;
        enableCompletion = true;
    };
}
