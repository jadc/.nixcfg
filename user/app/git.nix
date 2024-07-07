{
    programs.git = {
        enable = true;

        userName = "jadc";
        userEmail = "git@jad.red";

        # TODO: git config --global init.defaultBranch main
        # TODO: git config --global push.autoSetupRemote or something
    };
    programs.gh.enable = true;
}
