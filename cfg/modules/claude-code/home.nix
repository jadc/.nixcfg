{ config, lib, pkgs, ... }:

let
    name = "claude-code";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = with lib; {
        enable = mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.claude-code = {
            enable = true;
            commands = {
                create-prompt = ./commands/create-prompt.md;
                run-prompt = ./commands/run-prompt.md;
            };
        };
        cfg.const.aliases.claude = "${pkgs.claude-code}/bin/claude --allow-dangerously-skip-permissions";
    };
}
