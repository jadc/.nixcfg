{
    config.common = {
        arch = "x86_64-linux";
        hostname = "jadc";
        username = "jad";
        home = "/home/jad";

        rootDevice = "/dev/nvme0n1";
        bootMountPoint = "/boot";

        aliases = {
            # Default flags
            sudo="sudo -E";
            du="du -h";
            cp="cp -ivp";
            mv="mv -iv";
            mkdir="mkdir -pv";
            make="make -j$(nproc)";

            ## Colors
            # ls="ls -hN --color=auto --group-directories-first";
            grep="grep --color=auto";
            fgrep="fgrep --color=auto";
            egrep="egrep --color=auto";
            diff="diff --color=auto";
        };
    };
}
