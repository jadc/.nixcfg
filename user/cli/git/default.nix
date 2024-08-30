{
    programs.git = {
        enable = true;

        # Credentials
        userName = "jadc";
        userEmail = "chehimj@gmail.com";

        # Configuration
        ignores = [ ".DS_Store" ];
        extraConfig = {
            init.defaultBranch = "main";
            push.autoSetupRemote = true;
        };

        # Prettier diffs
        delta.enable = true;
    };
    programs.gh.enable = true;
}
