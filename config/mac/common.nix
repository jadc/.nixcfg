{
    config.common = {
        arch = "aarch64-darwin";
        hostname = "jadc";
        username = "jad";

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
