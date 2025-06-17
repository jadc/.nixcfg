{
    programs.git = {
        enable = true;

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
