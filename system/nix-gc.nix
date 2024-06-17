{
    # Clean >= 30 day old generations every week
    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 30d";
    };
}
