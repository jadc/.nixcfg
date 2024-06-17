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
        autosuggestion.enable = true;
        syntaxHighlighting.enable = true;
        enableCompletion = true;
        inherit shellAliases;
    };

    # Backup shell
    programs.bash = {
        enable = true;
        enableCompletion = true;
        inherit shellAliases;
    };
}
