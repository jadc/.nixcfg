{ ... }:

let
    name = baseNameOf (toString ./.);
in
{
    flake.modules.generic.${name} = { lib, ... }: {
        options.cfg.${name} = {
            enable = lib.mkEnableOption name;
        };
    };

    flake.modules.nixos.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            # Set default shell to zsh for all users
            programs.zsh.enable = true;
            environment.shells = [ pkgs.zsh ];
            users.defaultUserShell = pkgs.zsh;

            # Paths to link
            environment.pathsToLink = [
                "/share/bash-completion"
                "/share/zsh"
            ];
        };
    };

    flake.modules.homeManager.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.zsh = {
                enable = true;
                shellAliases = config.cfg.const.aliases;
                autosuggestion.enable = true;
                enableCompletion = true;
                syntaxHighlighting.enable = true;
                dotDir = "${config.xdg.configHome}/zsh";

                history = {
                    path = "${config.xdg.stateHome}/zsh/.zsh_history";
                    expireDuplicatesFirst = true;
                    extended = true;
                    ignoreAllDups = true;
                    ignoreDups = true;
                    share = true;
                };

                # Appended to end of .zshrc
                initContent = let
                        C = "\\e[1;34m";
                        G = "\\e[1;33m";
                        B = "\\e[0;90m";
                        NC = "\\e[0m";
                    in ''
                    source ${config.home.homeDirectory}/.zshrc

                    setopt BANG_HIST                # Treat the '!' character specially during expansion.
                    setopt INC_APPEND_HISTORY       # Write to the history file immediately, not when the shell exits.
                    setopt HIST_REDUCE_BLANKS       # Remove superfluous blanks before recording entry.
                    setopt CSH_NULL_GLOB            # Delete pattern from argument list instead of reporting

                    bindkey -v                      # Use vi keybindings

                    # Prompt
                    export PS1='%F{8}%1~%f %(!.%F{red}.%F{blue})$%f '

                    # Neofetch knockoff
                    i=$(cat /proc/uptime | awk -F'.' '{print $1}')
                    ((i/=60, min=i%60, hrs=i/60))
                    echo "${B} ,o()()o,  ${C}$USER${NC}"
                    echo "${B},o'    'o,  ${C}dt${NC}  $(date '+%b. %d' | awk '{print tolower($0)}')"
                    echo "${B}'O ${G}.  .${B} O'  ${C}up${NC}  $(printf "%dh %02dm" $hrs $min)"
                    echo "${B}  ·____·"
                    echo ""
                '';
            };

            # Some applications write to ~/.zshrc imperatively for their setup.
            # It is therefore sourced in the main config, so it needs to at least exist.
            home.activation.createZshrc = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                [ -f "$HOME/.zshrc" ] || touch "$HOME/.zshrc"
            '';

            cfg.save.home = {
                dirs = [ ".local/state/zsh" ];
                files = [ ".zshrc" ];
            };
        };
    };
}
