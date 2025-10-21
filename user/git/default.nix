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

        settings = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            pull.rebase = true;                             # default to rebase
            credential.helper = "cache --timeout=86400";    # store credentials in memory
            core.fileMode = false;                          # ignore file permissions
        };

    };

    programs.gh.enable = true;

    # Prettier diffs
    programs.delta = {
        enable = true;
        enableGitIntegration = true;
    };
}
