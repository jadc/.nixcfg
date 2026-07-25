{ ... }:

{
    flake.modules.generic.const = { lib, ... }: {
        options.cfg.const = {
            aliases = lib.mkOption {
                type = lib.types.attrsOf lib.types.str;
                description = "The shell aliases of the system";
                default = {};
            };

            stateVersion = lib.mkOption {
                type = lib.types.str;
                description = "The NixOS / Home Manager state version";
                default = "26.05";
            };
        };
    };

    flake.modules.homeManager.const = { lib, ... }: {
        cfg.const.aliases = {
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
    };
}
