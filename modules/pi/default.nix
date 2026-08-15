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
            programs.pi-coding-agent = {
                enable = true;
                extraPackages = [ pkgs.nodejs_latest ];
                settings = {
                    theme = "gh-dark";

                    packages = [
                        # Theme
                        "npm:pi-gh-dark-theme"

                        # Extensions
                        "npm:@tintinweb/pi-subagents"
                        "npm:pi-lens"
                        "npm:pi-web-access"
                        {
                            source = "npm:mattpocock-skills";
                            skills = [ "skills/productivity/grill-me/SKILL.md" ];
                        }
                    ];

                    skills = let home = config.home.homeDirectory; in [
                        "${home}/.claude/skills"
                        "${home}/.codex/skills"
                    ];

                    # Disable telemetry.
                    enableInstallTelemetry = false;
                    enableAnalytics = false;

                    # UI Behaviour
                    tuiMode = "fullscreen";
                    terminal = {
                        # Clear empty rows when content shrinks; can cause flicker.
                        clearOnShrink = true;

                        # Show OSC 9;4 progress indicators in the terminal tab bar.
                        showTerminalProgress = true;
                    };
                };
            };

            cfg.save.home.dirs = [ ".pi/agent" ];
        };
    };
}
