{
    # Enable networking
    networking.networkmanager.enable = true;

    # Add user to networkmanager group
    users.users.jad.extraGroups = [ "networkmanager" ];
}
