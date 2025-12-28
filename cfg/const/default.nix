{ lib, ... }:

{
    options.cfg.const = with lib; {
        profile = mkOption {
            type = types.str;
            description = "The profile of the system";
        };

        arch = mkOption {
            type = types.str;
            default = "x86_64-linux";
            description = "The architecture of the system";
        };

        username = mkOption {
            type = types.str;
            description = "The username of the user";
        };

        aliases = mkOption {
            type = types.attrsOf types.str;
            description = "The shell aliases of the system";
            default = {};
        };
    };

    # Default aliases
    config.cfg.const.aliases = with lib; {
        # Default flags
        sudo  = mkDefault "sudo -E";
        du    = mkDefault "du -h";
        cp    = mkDefault "cp -ivp";
        mv    = mkDefault "mv -iv";
        mkdir = mkDefault "mkdir -pv";
        make  = mkDefault "make -j$(nproc)";

        ## Colors
        grep  = mkDefault "grep --color=auto";
        fgrep = mkDefault "fgrep --color=auto";
        egrep = mkDefault "egrep --color=auto";
        diff  = mkDefault "diff --color=auto";

        # New
        diffs = mkDefault "diff -W $(tput cols) --color=always --side-by-side --left-column";
    };
}
