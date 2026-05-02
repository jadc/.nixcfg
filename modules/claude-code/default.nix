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
    };
}
