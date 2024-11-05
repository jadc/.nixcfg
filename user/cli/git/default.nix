{
    programs.git = {
        enable = true;

        # Credentials
        userName = "jadc";
        userEmail = "chehimj@gmail.com";

        # Configuration
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
        ];
        extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
            pull.rebase = false;    # always merge
        };

        # Prettier diffs
        delta.enable = true;
    };
    programs.gh.enable = true;
}
