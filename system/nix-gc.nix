{
    # Clean >= 30 day old generations every week
    nix.gc = {
        automatic = true;
        interval = "weekly";
        options = "--delete-older-than 7d";
    };
}
