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

    flake.modules.homeManager.${name} = { config, lib, ... }: let self = config.cfg.${name}; in {
        config = lib.mkIf self.enable {
            programs.git = {
                enable = true;
                lfs.enable = true;

                ignores = [
                    "**/.DS_Store"
                    "**/._.DS_Store"
                    "*.jad"
                    "*.log"
                    "*~"
                    ".DS_Store"
                    "._.DS_Store"
                    ".cache"
                    ".idea"
                    ".vscode"
                    "Thumbs.db"
                    "__pycache__"
                    "build"
                    "compile_commands.json"
                    "log"
                ];

                settings = {
                    init.defaultBranch = "main";

                    # When branching from a local branch, point to same upstream.
                    branch.autoSetupMerge = "inherit";
                    # Sort branch list by most recently committed to first.
                    branch.sort = "-committerdate";
                    # Set upstream branch on first push.
                    push.autoSetupRemote = true;
                    # Rebase when pulling, instead of merge commits.
                    pull.rebase = true;
                    # Temporarily stash uncommitted changes during a rebase.
                    rebase.autoStash = true;
                    # Remove references to deleted remote branches/tags during fetch.
                    fetch.prune = true;
                    fetch.pruneTags = true;
                    # Store credentials in memory.
                    credential.helper = "cache --timeout=86400";
                    # Ignore file permissions.
                    core.fileMode = false;
                    # More context in conflict markers.
                    merge.conflictStyle = "zdiff3";
                    # Often produces more readable diffs.
                    diff.algorithm = "histogram";
                    # Highlight moved lines in diffs.
                    diff.colorMoved = "zebra";

                    alias = {
                        a = "add";
                        b = "branch -v";
                        c = "commit";
                        ca = "commit --amend --no-edit";
                        last = "log -1 HEAD --stat";
                        lg = "log --oneline --graph --decorate --all";
                        s = "status";
                        d = "diff";
                        ds = "diff --staged";
                    };
                };

            };

            programs.gh.enable = true;

            # Use delta as Git pager.
            programs.delta = {
                enable = true;
                enableGitIntegration = true;
            };

            # GitHub OAuth tokens and config.
            cfg.save.home.dirs = [ ".config/gh" ];
        };
    };
}
