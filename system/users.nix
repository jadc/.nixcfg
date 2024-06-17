{
    # Create user
    users.users = {
        jad = {
            isNormalUser = true;
            description = "jad";
            extraGroups = [ "wheel" ];
        };
    };

    # Enable automatic login for the user.
    services.getty.autologinUser = "jad";
}
