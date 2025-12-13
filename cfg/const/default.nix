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
            type = types.attrs;
            description = "The shell aliases of the system";

            default = {
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
        };
    };
}
