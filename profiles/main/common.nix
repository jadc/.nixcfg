{
    arch = "x86_64-linux";
    hostname = "jadc";
    username = "jad";

    rootDevice = "/dev/vda";
    bootMountPoint = "/boot";

    region = {
        timeZone = "America/Edmonton";
        locale = "en_CA.UTF-8";
    };

    aliases = {
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
    };
}
