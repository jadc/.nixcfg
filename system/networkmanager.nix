{ common, ... }:

{
    # Enable networking
    networking.networkmanager.enable = true;

    # Add user to networkmanager group
    users.users.${common.username}.extraGroups = [ "networkmanager" ];
}
