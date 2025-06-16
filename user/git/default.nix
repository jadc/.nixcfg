{
    programs.git = {
        enable = true;

        ignores = [
            ".DS_Store"
            "._.DS_Store"
            "**/.DS_Store"
            "**/._.DS_Store"
            ".vscode"
            ".idea"
            "Thumbs.db"
            "log"
            "*.log"
            "*~"
            "__pycache__"
            "*.jad"
        ];
        extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            pull.rebase = false;                            # default to merge
            credential.helper = "cache --timeout=86400";    # store credentials in memory
            core.fileMode = false;                          # ignore file permissions
        };

        # Prettier diffs
        delta.enable = true;
    };
    programs.gh.enable = true;
}
