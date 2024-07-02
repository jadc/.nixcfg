{ config, ... }:

{
    # Enable networking
    networking.networkmanager.enable = true;

    # Add user to networkmanager group
    users.users.${config.common.username}.extraGroups = [ "networkmanager" ];
}
