{
    config.common.aliases = {
        # Default flags
        sudo="sudo -E";
        du="du -h";
        cp="cp -ivp";
        mv="mv -iv";
        mkdir="mkdir -pv";
        make="make -j$(nproc)";

        ## Colors
        grep="grep --color=auto";
        fgrep="fgrep --color=auto";
        egrep="egrep --color=auto";
        diff="diff --color=auto";

        # New
        diffs="diff -W $(tput cols) --color=always --side-by-side --left-column";
    };
}
