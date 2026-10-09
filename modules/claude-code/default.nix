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

    flake.modules.homeManager.${name} = { config, lib, pkgs, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.claude-code.enable = true;
            cfg.const.aliases.claude = "${pkgs.claude-code}/bin/claude --dangerously-skip-permissions";

            home.file.".claude/statusline-command.sh" = {
                source = "${pkgs.writeShellApplication {
                    name = "statusline-command";
                    runtimeInputs = [ pkgs.jq pkgs.gawk pkgs.git pkgs.coreutils ];
                    text = builtins.readFile ./statusline-command.sh;
                }}/bin/statusline-command";
                executable = true;
            };

            home.activation.claudeSettings = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
                if [ ! -e "$HOME/.claude/settings.json" ]; then
                    run mkdir -p "$HOME/.claude"
                    run install -m 644 ${./settings.json} "$HOME/.claude/settings.json"
                fi
            '';

            cfg.save.home = {
                dirs = [ ".claude" ];
                files = [ ".claude.json" ];
            };
        };
    };
}
