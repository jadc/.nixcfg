{ lib, ... }:

{
    options.cfg.const = {
        profile = lib.mkOption {
            type = lib.types.str;
            description = "The profile of the system";
        };

        arch = lib.mkOption {
            type = lib.types.str;
            default = "x86_64-linux";
            description = "The architecture of the system";
        };

        username = lib.mkOption {
            type = lib.types.str;
            description = "The username of the user";
        };

        aliases = lib.mkOption {
            type = lib.types.attrsOf lib.types.str;
            description = "The shell aliases of the system";
            default = {};
        };
    };

    # Default aliases
    config.cfg.const.aliases = {
        # Default flags
        sudo  = lib.mkDefault "sudo -E";
        du    = lib.mkDefault "du -h";
        cp    = lib.mkDefault "cp -ivp";
        mv    = lib.mkDefault "mv -iv";
        mkdir = lib.mkDefault "mkdir -pv";
        make  = lib.mkDefault "make -j$(nproc)";

        ## Colors
        grep  = lib.mkDefault "grep --color=auto";
        fgrep = lib.mkDefault "fgrep --color=auto";
        egrep = lib.mkDefault "egrep --color=auto";
        diff  = lib.mkDefault "diff --color=auto";

        # New
        diffs = lib.mkDefault "diff -W $(tput cols) --color=always --side-by-side --left-column";
    };
}
