{ config, lib, pkgs, ... }:

let
    name = "claude-code";
    self = config.cfg.user.${name};
in
{
    options.cfg.user.${name} = {
        enable = lib.mkEnableOption name;
    };

    config = lib.mkIf self.enable {
        programs.claude-code = {
            enable = true;
            settings = {
                enabledPlugins = {
                    "superpowers@claude-plugins-official" = true;
                };
                effortLevel = "high";
                skipDangerousModePermissionPrompt = true;

                # Remove "Co-Authored by" watermark in commit messages
                attribution.commit = "";
            };
        };
        cfg.const.aliases.claude = "${pkgs.claude-code}/bin/claude --allow-dangerously-skip-permissions";
    };
}
