{
    programs.git = {
        enable = true;

        userName = "jadc";
        userEmail = "chehimj@gmail.com";

        # TODO: git config --global init.defaultBranch main
        # TODO: git config --global push.autoSetupRemote or something

        # Prettier diffs
        delta.enable = true;
    };
    programs.gh.enable = true;
}
